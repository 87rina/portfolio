class User < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true

  has_many :posts, dependent: :destroy
  has_many :ai_responses, through: :posts
  belongs_to :character, optional: true
  has_one_attached :avatar

  before_save :resize_avatar
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable,
         :omniauthable, omniauth_providers: %i[ line ]

  private
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
