require 'digest/sha1'

FactoryGirl.define do
  factory :issue do
    association :app

    fingerprint { Digest::SHA1.hexdigest(Faker::Lorem.characters(32)) }
    status 0

    error_class 'SomeClass'
    message 'Severe crash message'
    environment_name 'production'

    occurences_count 1

    first_occurence_at Time.now
    last_occurence_at Time.now
  end
end