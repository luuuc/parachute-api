class Occurence < ActiveRecord::Base
  belongs_to :issue
  has_one :backtrace, through: :issue

  store_accessor :notifier_data
  store_accessor :server_data
  store_accessor :request_data
  store_accessor :environment_data
  store_accessor :session_data
  store_accessor :user_data
end
