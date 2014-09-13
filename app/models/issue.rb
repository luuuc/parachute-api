class Issue < ActiveRecord::Base
  belongs_to :app
  has_one :backtrace
  has_many :occurences
end
