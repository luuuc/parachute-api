# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :invitation do
    email "MyString"
    admin false
    settings_data ""
    token "MyString"
  end
end
