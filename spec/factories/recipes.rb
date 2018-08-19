FactoryBot.define do
  factory :recipe do
    title { Faker::Lorem.unique.word }
    steps { Faker::Lorem.word }
    ingredients { Faker::Lorem.word }
  end
end
