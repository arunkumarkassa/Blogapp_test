class Article < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  validates :title, presence: true, length: { minimum: 4, maximum: 100 }
  validates :description, presence: true, length: { minimum: 10, maximum: 300 }
  def self.generate_csv
    attributes = %w[title description]
    CSV.generate do |csv|
      csv << attributes
      all.each do |record|
        csv << record.attributes.values_at(*attributes)
      end
    end
  end
end
