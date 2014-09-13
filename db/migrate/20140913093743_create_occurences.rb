class CreateOccurences < ActiveRecord::Migration
  def change
    create_table :occurences, id: :uuid do |t|
      t.uuid :issue_id

      t.string :fingerprint

      t.hstore :notifier_data
      t.hstore :server_data
      t.hstore :request_data
      t.hstore :environment_data
      t.hstore :session_data
      t.hstore :user_data
      t.hstore :additional_data

      t.timestamps
    end

    add_index :occurences, :issue_id
  end
end
