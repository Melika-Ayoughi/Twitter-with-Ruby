class CreateBlockships < ActiveRecord::Migration
  def change
    create_table :blockships do |t|
      t.integer :blocker_id
      t.integer :blocked_id

      t.timestamps null: false
    end
  end
end
