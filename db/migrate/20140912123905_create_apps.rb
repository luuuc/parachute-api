class CreateApps < ActiveRecord::Migration
  def change
    create_table :apps, id: :uuid do |t|
      t.string :name,            null: false
      t.string :api_key,         null: false
      t.hstore :repository_data, null: false, default: ''

      t.timestamps
    end

    add_index :apps, :name, unique: true
    add_index :apps, :api_key, unique: true
  end
end
