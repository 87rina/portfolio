class BadgeService
  def initialize(user)
    @user = user
  end
  
  def evaluate!
    check_first_post
    check_50_posts
    check_100_posts
    check_consecutive_posts(3, "継続投稿バッジ（3日）")
    check_consecutive_posts(7, "1週間継続投稿バッジ")
    check_consecutive_posts(30, "1ヶ月継続投稿バッジ")
  end

  private

  def check_first_post
    if @user.posts.count >= 1
      give_badge("初投稿バッジ")
    end
  end

  def check_50_posts
    if @user.posts.count >= 50
      give_badge("50投稿達成バッジ")
    end
  end

  def check_100_posts
    if @user.posts.count >= 100
      give_badge("100投稿達成バッジ")
    end
  end

  def check_consecutive_posts(threshold, badge_name)
    dates = @user.posts.pluck(:created_at).map(&:to_date).uniq.sort.reverse # 連続投稿日数を数える
    if calculate_consecutive_days(dates) >= threshold
      give_badge(badge_name)
    end
  end
  
  def calculate_consecutive_days(dates)
    count = 1
    dates.each_cons(2) { |prev, curr| count += 1 if prev == curr + 1 }
    count
  end
  
  def give_badge(name)
    badge = Badge.find_by(name: name)
    @user.badges << badge if badge && !@user.badges.include?(badge) # すでに持っている場合は重複しないようにチェック
  end
end
  