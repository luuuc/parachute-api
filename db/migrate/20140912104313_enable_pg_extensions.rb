class EnablePgExtensions < ActiveRecord::Migration
  def self.up
    if Rails.env.development?
      execute 'CREATE EXTENSION hstore'
      execute 'CREATE EXTENSION "uuid-ossp"'
    end
  end

  def self.down
    if Rails.env.development?
      execute 'DROP EXTENSION hstore'
      execute 'DROP EXTENSION "uuid-ossp"'
    end
  end
end
