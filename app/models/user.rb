class User < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true

  has_many :posts, dependent: :destroy
  has_many :ai_responses, through: :posts
  belongs_to :character, optional: true
  has_one_attached :avatar
  has_many :user_badges
  has_many :badges, through: :user_badges

  before_save :resize_avatar

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  # posts集計のインスタンスメソッド
  def total_posts_count # 累計記録数
    posts.count
  end

  def consecutive_days # 連続記録日数
    dates = posts.pluck(:created_at).map(&:to_date).uniq.sort.reverse
    count = 1
    dates.each_cons(2) { |prev, curr| count += 1 if prev == curr + 1 }
    count
  end

  def last_posted_at # 最終投稿日　LINE通知機能に使用
    posts.order(created_at: :desc).limit(1).pluck(:created_at).first
  end

  private
  # <プロフィール>
  # 保存時に画像サイズをリサイズしてS3へのアップロード容量を制御
  def resize_avatar
    return unless avatar.attached?

    avatar.variant(resize_to_limit: [ 400, 400 ]).processed.tap do |variant|
      avatar.attach(
        io: StringIO.new(variant.download),
        filename: avatar.filename,
        content_type: avatar.content_type
      )
    end
  end
end
