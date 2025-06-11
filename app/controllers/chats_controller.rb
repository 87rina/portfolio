class ChatsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index create]

  def index
  end

  def create
    if user_signed_in?
      post = current_user.posts.create!(content: params[:content])
    else
      post = Post.create!(content: params[:content], session_id: session.id)
    end

    GenerateAiResponseJob.perform_later(post.id)

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to chats_path }
    end
  end

  private

  def post_params
  params.require(:post).permit(:content)
  end
end
