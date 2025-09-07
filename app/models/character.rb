class Character < ApplicationRecord
  has_many :users
  has_one_attached :image

  validates :name, presence: true
  validates :system_prompt, presence: true
end
