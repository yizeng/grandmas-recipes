require 'rails_helper'

RSpec.describe Recipe, type: :model do
  it { should have_many(:photos).dependent(:destroy) }
  it { should have_many(:tags).dependent(:destroy) }

  it { should validate_uniqueness_of(:title) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:steps) }
  it { should validate_presence_of(:ingredients) }
end
