FactoryGirl.define do
  factory :invitation do
    association :admin

    name { Faker::Name.first_name }
    email { Faker::Internet.email }
    admin false
    settings_data {
      {
        language: I18n.available_locales.map(&:to_s).sample,
        time_zone: ActiveSupport::TimeZone.all.map(&:name).sample
      }
    }
  end
end
