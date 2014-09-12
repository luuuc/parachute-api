class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations, id: :uuid do |t|
      t.uuid :invited_by, null: false

      t.string :name, null: false
      t.string :email, null: false
      t.boolean :admin, default: false
      t.hstore :settings_data, default: '', null: false
      t.string :token, null: false

      t.timestamps
    end

    add_index :invitations, :email, unique: true
    add_index :invitations, :token, unique: true
  end
end
