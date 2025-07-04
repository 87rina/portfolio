class AiResponse < ApplicationRecord
  validates :content, presence: true, length: { maximum: 65_535 }

  belongs_to :post
end
