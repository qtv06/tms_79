require "faker"

FactoryBot.define do
  factory :user do
    name {Faker::Name.name}
    email {Faker::Internet.email}
    password {"password"}
    password_confirmation {"password"}
    address {Faker::Address.full_address}
    phone_number {Faker::Number.number(10)}
    role {"trainee"}
  end
end
