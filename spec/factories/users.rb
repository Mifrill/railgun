FactoryGirl.define do
  factory :user do
    email { Faker::Internet.unique.email }
    password Faker::Internet.password
    password_confirmation Faker::Internet.password

    # trait :confirmed do
    #   confirmed_at { Faker::Date.backward(3) }
    # end

    factory :employee do
      #confirmed

      factory :administrator do
        # TODO: role = :administrator
      end
    end
  end
end
