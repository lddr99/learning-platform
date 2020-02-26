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
