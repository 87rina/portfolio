class CheckInactiveUsersJob < ApplicationJob
  queue_as :default

  def perform
    User.find_each do |user|
      last_post = user.last_posted_at
      if last_post.nil? || last_post <= 5.days.ago
        LineNotifyJob.perform_later(user.id, "5日以上記録がありません。今日の良かったことを記録してみませんか？")
      end
    end
  end
end
