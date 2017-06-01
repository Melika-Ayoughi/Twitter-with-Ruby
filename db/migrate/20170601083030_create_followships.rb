class CreateFollowships < ActiveRecord::Migration
  def change
    create_table :followships do |t|
      t.integer :follower_id
      t.integer :following_id

      t.timestamps null: false
    end
  end
end
