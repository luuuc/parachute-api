class Invitation < ActiveRecord::Base
  include Tokenize

  store_accessor :settings_data, :language, :time_zone

  belongs_to :user, foreign_key: :invited_by

  before_create { generate_token(:authentication_token, {secure: true}) }

  validates :name, presence: true
  validates :email, email: true,
                    uniqueness: { case_sensitive: false }
  validates :language, inclusion: { in: I18n.available_locales.map(&:to_s) }, allow_blank: true
  validates :time_zone, inclusion: { in: ActiveSupport::TimeZone.all.map(&:name) }, allow_blank: true
end
