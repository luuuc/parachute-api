class CreateWatchers < ActiveRecord::Migration
  def change
    create_table :watchers, id: :uuid do |t|
      t.uuid :user_id
      t.uuid :app_id
      t.boolean :notify, default: true

      t.timestamps
    end
  end
end
