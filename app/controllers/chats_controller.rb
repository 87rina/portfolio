class ChatsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index create]

  def index
  end

  def create
    if user_signed_in?
      @post = current_user.posts.create!(content: params[:content])
      BadgeService.new(current_user).evaluate!
    else
      @post = Post.create!(content: params[:content], session_id: session.id)
    end

    GenerateAiResponseJob.perform_later(@post.id)

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to chats_path }
    end
  end

  def reset_chat
    if current_user
      current_user.posts.destroy_all
    else
      Post.where(session_id: session.id).destroy_all
    end

    redirect_to root_path
  end

  private

  def post_params
  params.require(:post).permit(:content)
  end
end
