FactoryGirl.define do
  factory :watcher do
    notify false

    association :user
    association :app
  end
end
