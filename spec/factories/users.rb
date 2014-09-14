FactoryGirl.define do
  factory :user do
    admin false
    name { Faker::Name.first_name }
    email { Faker::Internet.email }
    settings_data {
      {
        language: I18n.available_locales.map(&:to_s).sample,
        time_zone: ActiveSupport::TimeZone.all.map(&:name).sample
      }
    }

    password              "blahblah"
    password_confirmation "blahblah"
    #authentication { Faker::Lorem.characters(32) }

    factory :admin do
      admin true
    end

    factory :invalid_user do
      name nil
    end

    factory :unconfirmed_email do
      unconfirmed_email { Faker::Internet.email }
      # email_confirmation_token { Faker::Lorem.characters(128) }
      # email_confirmation_sent_at "MyString"
    end

    factory :password_reset do
      # password_reset_token { Faker::Lorem.characters(128) }
      # password_reset_sent_at "2014-09-12 12:54:51"
    end

    factory :inactive do
      active false
    end
  end
end
