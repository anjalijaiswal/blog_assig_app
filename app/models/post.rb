class Post < ApplicationRecord
  has_many :impressions, as: :impressionable
  validates :title, :body, presence: true
  validates :title, uniqueness: true

  def impression_count
    impressions.size
  end

  def update_count
    update(count: count + 1)
  end

  def unique_impression_count
    impressions.group(:ip_address).size
  end

  def self.search(search)
    where("title ILIKE ?", "%#{search}%")
    where("body ILIKE ?", "%#{search}%")
  end
end
