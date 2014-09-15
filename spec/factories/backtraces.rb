FactoryGirl.define do
  factory :backtrace do
    association :issue

    line 33
    location '[PROJECT_ROOT]/app/views/account/addresses/index.html.erb'
    method_name 'block   in _app_views_account_addresses_index_html_erb___2083754484407409211_70195927201760'
  end
end
