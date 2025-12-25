class Room < ApplicationRecord
  belongs_to :user
  has_many :reservations, dependent: :destroy

  has_one_attached :image

  validates :name, presence: true
  validates :description, presence: true
  validates :price, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1 }
  validates :address, presence: true

  AREAS = %w[東京 大阪 京都 札幌].freeze

  scope :by_area, ->(area) { return all if area.blank? where('address LIKE ?', "%#{area}%") }

  scope :by_keyword, ->(q) { return all if q.blank? where('name LIKE :q OR description LIKE :q', q: "%#{q}%") }

end
