class PostsController < ApplicationController
  def index
    @user = current_user
    @posts = @user.posts.order(created_at: :desc).page(params[:page])
  end

  def show
    @post = Post.find(params[:id])
    @ai_response = @post.ai_response
  end

  def destroy
    post = current_user.posts.find(params[:id])
    post.destroy!
    redirect_to posts_path, notice: t("defaults.flash_message.deleted", item: Post.model_name.human), status: :see_other
  end
end
