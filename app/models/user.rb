class User < ActiveRecord::Base
  include Tokenize

  has_secure_password

  DEFAULT_LANGUAGE  = 'en'
  DEFAULT_TIME_ZONE = 'UTC'
  DEFAULT_PER_PAGE  = 20

  store_accessor :settings_data, :language, :time_zone, :per_page

  has_many :apps, through: :watchers
  has_many :invitations, foreign_key: :invited_by

  before_create { generate_token(:authentication_token, {secure: true}) }

  validates :name, presence: true,
                  format: { with: /\A[a-zA-Z0-9\-]+\z/ },
                  uniqueness: { case_sensitive: false }
  validates :email, email: true,
                    uniqueness: { case_sensitive: false }
  validates :language, inclusion: { in: I18n.available_locales.map(&:to_s) }
  validates :time_zone, inclusion: { in: ActiveSupport::TimeZone.all.map(&:name) }

  def regenerate_authentication_token
    generate_token(:authentication_token, {secure: true})
    save
  end
end
