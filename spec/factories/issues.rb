require 'digest/sha1'

FactoryGirl.define do
  factory :issue do
    association :app

    fingerprint { Digest::SHA1.hexdigest(Faker::Lorem.characters(32)) }
    status { rand(3) }

    error_class { %w(Product Classified Cart Variant Import User).sample }
    message 'Severe crash message'
    environment_name { %w(production staging beta development).sample }

    occurences_count { rand(50) }

    first_occurence_at { Time.now - rand(24..72).hours }
    last_occurence_at { Time.now - rand(180).minutes }
  end
end