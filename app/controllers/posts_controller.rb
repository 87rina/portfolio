class PostsController < ApplicationController
  def index
    @user = current_user
    @posts = @user.posts.order(created_at: :desc).page(params[:page])
  end

  def show
    @post = Post.find(params[:id])
    @ai_response = @post.ai_response
  end

  def calendar
    @user = current_user

    if params[:date]
      date = Date.parse(params[:date])
      @posts = @user.posts.where(created_at: date.beginning_of_day..date.end_of_day)
                          .order(created_at: :desc).page(params[:page])
    else
      @posts = @user.posts.order(created_at: :desc).page(params[:page])
    end

    @date = params[:month] ? Date.parse(params[:month]) : Date.today.beginning_of_month
    @posts_by_date = @user.posts.where(created_at: @date.beginning_of_month..@date.end_of_month)
                                .group_by { |post| post.created_at.to_date }
  end

  def destroy
    post = current_user.posts.find(params[:id])
    post.destroy!
    redirect_to posts_path, notice: t("defaults.flash_message.deleted", item: Post.model_name.human), status: :see_other
  end
end
