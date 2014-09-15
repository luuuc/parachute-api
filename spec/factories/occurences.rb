FactoryGirl.define do
  factory :occurence do
    association :issue

    fingerprint { Digest::SHA1.hexdigest(Faker::Lorem.characters(32)) }
    notifier_data {
      {
        name: 'Parachute Notifier',
        version: '0.1',
        language: %w(ruby go python java php dotnet).sample,
        url: 'https://github.com/luuuc/parachute-ruby'
      }
    }
    server_data {
      {
        project_root: 'some/path/to/project',
        environment_name: %w(production staging beta development).sample,
        hostname: Faker::Internet.domain_name
      }
    }
    request_data {
      {
        url: Faker::Internet.url,
        action: %w(index show new create edit update destroy).sample,
        component: 'account/addresses',
        params: '{ action: "index", controller: "account/addresses" }'
      }
    }
    environment_data {
      {
        "REQUEST_METHOD" => %w(GET POST PATCH DELETE).sample,
        "PATH_INFO" => "/compte/adresses",
        "REMOTE_ADDR" => Faker::Internet.ip_v4_address,
        "SERVER_ADDR" => Faker::Internet.ip_v4_address,
        "SERVER_NAME" => Faker::Internet.domain_name,
        "SERVER_PORT" => %w(80 443).sample,
        "HTTP_HOST" => Faker::Internet.domain_name,
        "HTTP_X_FORWARDED_FOR" => Faker::Internet.ip_v4_address,
        "HTTP_X_FORWARDED_PROTO" => %w(http https).sample,
        "HTTP_CONNECTION" => "close",
        "HTTP_USER_AGENT" => "Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:31.0) Gecko/20100101 Firefox/31.0",
        "HTTP_ACCEPT" => "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8",
        "HTTP_ACCEPT_LANGUAGE" => "en-US,en;q=0.5",
        "HTTP_ACCEPT_ENCODING" => "gzip, deflate",
        "HTTP_CACHE_CONTROL" => "max-age=0",
        "REMOTE_PORT" => "53817",
        "ORIGINAL_FULLPATH" => "/compte/adresses",
      }
    }
    session_data {
      {
        session_id: Faker::Lorem.characters(32),
        csrf_token: Faker::Lorem.characters(44),
        return_to: Faker::Internet.url
      }
    }
    user_data {
      {
        id: rand(5000),
        name: Faker::Internet.user_name,
        email: Faker::Internet.email
      }
    }
  end
end
