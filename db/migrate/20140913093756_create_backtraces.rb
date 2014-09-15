class CreateBacktraces < ActiveRecord::Migration
  def change
    create_table :backtraces, id: :uuid do |t|
      t.uuid :issue_id

      t.integer :line
      t.string :location
      t.string :method_name

      t.timestamps
    end
  end
end
