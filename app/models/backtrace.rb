class Backtrace < ActiveRecord::Base
  belongs_to :issue
  has_many :occurences, through: :issue
end
