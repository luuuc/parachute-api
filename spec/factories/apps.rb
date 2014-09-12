FactoryGirl.define do
  factory :app do
    name { Faker::Internet.user_name(Faker::App.name, ['-']) }
    api_key { Faker::Lorem.characters(32) }
    repository_data {
      {
        repo_provider: %w(github gitlab bitbucket).sample,
        repo_path: "#{Faker::Internet.user_name(nil, %w(- _))}/#{Faker::App.name}",
        repo_branch: 'master'
      }
    }
  end
end
