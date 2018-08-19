class Recipe < ApplicationRecord
  validates :title, uniqueness: true
  validates :title, presence: true
  validates :steps, presence: true
  validates :ingredients, presence: true

  has_many :photos, dependent: :destroy
  has_many :tags, dependent: :destroy
end
