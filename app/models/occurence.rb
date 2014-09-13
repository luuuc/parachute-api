class Occurence < ActiveRecord::Base
  belongs_to :issue
  has_one :backtrace, through: :issue

  store_accessor :notifier_data, :name, :url, :version, :language
  store_accessor :request_data, :url, :component, :action
end
