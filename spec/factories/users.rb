FactoryGirl.define do
  factory :user do
    email { Faker::Internet.unique.email }
    password Faker::Internet.password
    password_confirmation Faker::Internet.password

    UserRole::TITLES.each do |title|
      factory title do
        after :create do |user|
          create(:user_role, title, user: user)
        end
      end
    end
  end
end
