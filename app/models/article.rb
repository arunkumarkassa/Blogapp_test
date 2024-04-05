class Article < ApplicationRecord
  has_one_attached :image
  validates :title, presence: true, length: { minimum: 4, maximum: 100 }
  validates :description, presence: true, length: { minimum: 10, maximum: 300 }
end
