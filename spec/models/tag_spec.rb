require 'rails_helper'

RSpec.describe Tag, type: :model do
  it { should belong_to(:recipe) }

  it { should validate_uniqueness_of(:name) }
  it { should validate_presence_of(:name) }
end
