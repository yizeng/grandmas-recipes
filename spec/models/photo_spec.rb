require 'rails_helper'

RSpec.describe Photo, type: :model do
  it { should belong_to(:recipe) }

  it { should validate_uniqueness_of(:path) }
  it { should validate_presence_of(:path) }
end
