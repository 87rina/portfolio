class Post < ApplicationRecord
  validates :content, presence: true, length: { maximum: 65_535 }

  belongs_to :user, optional: true # 必ずしもログインユーザーに関連付けられていなくても良い
  has_one :ai_response, dependent: :destroy

  attribute :session_id, :string
  belongs_to :guest_user, class_name: "User", foreign_key: "session_id", optional: true

  after_create :check_badges # バッジ付与を投稿後にチェック

  def check_badges
    if self.user.present? 
      BadgeService.new(self.user).evaluate! # ユーザーの状態を評価して、必要ならバッジを付与
    end
  end
end
