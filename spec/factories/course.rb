FactoryBot.define do
  factory :course do
    name {Faker::Name.name}
    description {Faker::Lorem.paragraph}
    time_training {Faker::Number.number(3)}
  end
end
