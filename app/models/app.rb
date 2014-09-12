class App < ActiveRecord::Base
  include Tokenize

  store_accessor :repository_data, :repo_provider, :repo_path, :repo_branch

  has_many :watchers
  has_many :users, through: :watchers

  before_create { generate_token(:api_key, {secure: true}) }

  validates :name, presence: true,
                  format: { with: /\A[a-zA-Z0-9\-]+\z/ },
                  uniqueness: { case_sensitive: false }
end
