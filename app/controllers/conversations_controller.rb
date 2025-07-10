class ConversationsController < ApplicationController
  def show_history
    posts = if user_signed_in?
              current_user.posts.includes(:ai_response)
            else
              Post.includes(:ai_response).where(session_id: session.id)
            end
    # PostとAiResponseをcreated_atでソート        
    combined_messages = posts.flat_map do |post|
      [post, post.ai_response].compact
    end.sort_by(&:created_at)
    
    @messages = combined_messages.last(10)

    respond_to do |format|
      format.html { render partial: 'messages/history', locals: { messages: @messages } }
      format.turbo_stream do
        render turbo_stream: turbo_stream.update("conversation-history", partial: "messages/history", locals: { messages: @messages })
      end
    end
  end
end