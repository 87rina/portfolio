class Character < ApplicationRecord
  has_many :users

  validates :name, presence: true
  validates :system_prompt, presence: true
  validates :image_url, presence: true
end
  