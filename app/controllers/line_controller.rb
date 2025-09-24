class LineController < ApplicationController
  skip_before_action :verify_authenticity_token

  def webhook
    body = request.body.read
    signature = request.env['HTTP_X_LINE_SIGNATURE']

    client = Line::Bot::Client.new do |config|
      config.channel_secret = Rails.application.credentials.dig(:line, :channel_secret)
      config.channel_token  = Rails.application.credentials.dig(:line, :channel_token)
    end

    unless client.validate_signature(body, signature)
      return head :bad_request
    end

    events = client.parse_events_from(body)

    events.each do |event|
      case event
      when Line::Bot::Event::Follow
        line_user_id = event['source']['userId']

        # 誰のline_user_idか判定
        # LINE連携を待機している特定のユーザーをデータベースから探す
        user = User.find_by(waiting_for_line_link: true)
        if user
          user.update!(line_user_id: line_user_id, waiting_for_line_link: false)
        end
      end
    end

    head :ok
  end
end
