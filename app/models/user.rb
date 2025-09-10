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
         :recoverable, :rememberable, :validatable, :confirmable,
         :omniauthable, omniauth_providers: %i[ line ]

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

  # <LINEログイン>
  # SNS連携データを取得
  def social_profile(provider)
    social_profiles.select { |sp| sp.provider == provider.to_s }.first
  end
  # OmniAuth から受け取った認証情報をモデルの属性にセット
  def set_values(omniauth)
    return if provider.to_s != omniauth["provider"].to_s || uid != omniauth["uid"]
    credentials = omniauth["credentials"]
    info = omniauth["info"]
    access_token = credentials["refresh_token"]
    access_secret = credentials["secret"]
    credentials = credentials.to_json
    name = info["name"]
  end
  # SNSから取得した「ユーザープロフィール情報（raw_info）」をJSON形式で保存しDBに即時反映
  def set_values_by_raw_info(raw_info)
    self.raw_info = raw_info.to_json
    self.save!
  end
end
