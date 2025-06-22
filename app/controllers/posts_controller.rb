class PostsController < ApplicationController
  def index
    @posts = Post.includes(:user).order(created_at: :desc)
    # 合計件数
    @total_posts_count = @posts.count
    # 連続記録日数
    recorded_dates = @posts.pluck(:created_at).map(&:to_date).uniq.sort.reverse
    @consecutive_days = calculate_consecutive_days(recorded_dates)
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
