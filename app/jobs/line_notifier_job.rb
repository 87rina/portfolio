class LineNotifyJob < ApplicationJob
  queue_as :default

  def perform(user_id, message)
    user = User.find(user_id)
    return if user.line_user_id.blank?

    LineNotifier.push_message(user.line_user_id, message)
  end
end
