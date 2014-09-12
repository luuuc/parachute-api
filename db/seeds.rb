require 'faker'


User.delete_all
50.times do
  user = User.create(
    admin: [true, false].sample,
    name: Faker::Internet.user_name(nil, %w(-)),
    email: Faker::Internet.email,
    password: 'blahblah',
    password_confirmation: 'blahblah',
    language: I18n.available_locales.map{|l| l.to_s }.sample,
    time_zone: ActiveSupport::TimeZone.zones_map.values.map{|z| z.name}.sample,
    per_page: %w(10 20 30 40 50).sample,
  )
end


Watcher.delete_all
App.delete_all
10.times do
  app_name = Faker::Internet.user_name(Faker::App.name, ['-'])
  app = App.create(
    name: app_name,
    repo_provider: %w(github gitlab bitbucket).sample,
    repo_path: "#{Faker::Internet.user_name(nil, %w(- _))}/#{app_name}",
    repo_branch: 'master'
  )

  app.users << User.all.limit((1..20).to_a.sample)
end