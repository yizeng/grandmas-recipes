class Photo < ApplicationRecord
  validates :path, uniqueness: true
  validates :path, presence: true

  belongs_to :recipe, foreign_key: 'recipe_id'
end
