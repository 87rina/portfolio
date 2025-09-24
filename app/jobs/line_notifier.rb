class LineNotifyJob < ApplicationJob
  queue_as :default

  def perform(user_id, message)
    user = User.find(user_id)
    return if user.uid.blank?

    LineNotifier.push_message(user.uid, message)
  end
end
