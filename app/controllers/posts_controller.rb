class PostsController < ApplicationController
  def index
    @posts = current_user.posts.order(created_at: :desc).page(params[:page])
    # 合計件数
    @total_posts_count = @posts.count
    # 連続記録日数
    recorded_dates = @posts.pluck(:created_at).map(&:to_date).uniq.sort.reverse
    @consecutive_days = calculate_consecutive_days(recorded_dates)
  end

  def show
    @post = Post.find(params[:id])
    @ai_response = @post.ai_response
  end

  def destroy
    post = current_user.posts.find(params[:id])
    post.destroy!
    redirect_to posts_path, notice: t('defaults.flash_message.deleted', item: Post.model_name.human), status: :see_other
  end

  private

  def calculate_consecutive_days(dates)
    return 0 if dates.empty?

    count = 1
    (1...dates.length).each do |i|
      if dates[i] == dates[i - 1] - 1
        count += 1
      else
        break
      end
    end
    count
  end
end
