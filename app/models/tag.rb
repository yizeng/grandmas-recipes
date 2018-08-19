class Tag < ApplicationRecord
  validates :name, uniqueness: true
  validates :name, presence: true

  belongs_to :recipe, foreign_key: 'recipe_id'
end
