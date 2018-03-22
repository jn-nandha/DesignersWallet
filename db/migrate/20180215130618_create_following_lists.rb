class CreateFollowingLists < ActiveRecord::Migration[5.1]
  def change
    create_table :following_lists do |t|
      t.integer :follow_status
      t.references :to
      t.references :from
      t.timestamps
    end
  end
end