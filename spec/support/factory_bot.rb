require 'factory_bot'

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
end

FactoryBot.define do
  factory :user do
    email { 'user@test.com' }
    password { 'password' }
    password_confirmation { 'password' }
    is_admin { false }

    factory :admin_user do
      is_admin { true }
    end
  end
end

FactoryBot.define do
  factory :category do
    sequence(:name) { |n| "category #{n} name" }
  end

  factory :currency do
    name { 'TWD' }
  end

  factory :price do
    currency
    amount { 100 }
  end

  factory :course do
    title { 'Course Title' }
    is_available { true }
    duration_of_days { 12 }
    description { 'Course Description' }
    url { 'https://coures.com.tw' }
    category

    after(:create) do |course|
      create_list(:price, 1, course_id: course.id)
    end
  end
end
