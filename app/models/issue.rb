class Issue < ActiveRecord::Base
  belongs_to :app
  has_one :backtrace
  has_many :occurences

  validates :app, presence: true
  validates :fingerprint, presence: true, uniqueness: { scope: :app_id }
end
