class GenerateAiResponseJob < ApplicationJob
  queue_as :default

  def perform(post_id)
    post = Post.find(post_id)
    user_text = post.content

    ai_reply = OpenaiClient.new.generate_response(user_text)

    post.create_ai_response!(content: ai_reply)

    stream_id =
      if post.user.present? # postにユーザーIDがある場合
        "chat_user_#{post.user_id}"
      else
        "chat_guest_#{post.session_id}"
      end

    # Turbo Streamで返答を表示（broadcasting）
    Turbo::StreamsChannel.broadcast_append_to(
      stream_id,
      target: "chat_messages",
      partial: "chats/message",
      locals: { message: { user: post.content, ai: ai_reply } }
    )
  end
end
