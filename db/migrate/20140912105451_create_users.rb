class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users, id: :uuid do |t|
      t.boolean :admin,        default: false
      t.string :name,          null: false
      t.string :email,         null: false
      t.hstore :settings_data, default: '', null: false

      t.string :password_digest, null: false
      t.string :authentication_token,  null: false

      t.string :password_reset_token
      t.datetime :password_reset_sent_at

      t.string :unconfirmed_email
      t.string :email_confirmation_token
      t.datetime :email_confirmation_sent_at

      t.boolean :active,       default: true

      t.timestamps
    end

    add_index :users, :name, unique: true
    add_index :users, :email, unique: true
    add_index :users, :authentication_token, unique: true
  end
end
