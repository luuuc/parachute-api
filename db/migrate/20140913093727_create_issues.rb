class CreateIssues < ActiveRecord::Migration
  def change
    create_table :issues, id: :uuid do |t|
      t.uuid :app_id

      t.string :fingerprint

      t.integer :status

      t.string :error_class
      t.string :message
      t.string :environment_name, default: 'unknown'
      t.string :framework, default: 'unknown'

      t.integer :occurences_count, default: 0

      t.datetime :first_occurence_at
      t.datetime :last_occurence_at

      t.timestamps
    end

    add_index :issues, :app_id
    add_index :issues, [:app_id, :fingerprint], unique: true
  end
end
