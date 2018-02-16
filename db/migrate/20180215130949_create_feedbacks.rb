class CreateFeedbacks < ActiveRecord::Migration[5.1]
  def change
    create_table :feedbacks do |t|
      t.boolean :like
      t.text :report
      t.references :user
      t.references :design
      t.timestamps
    end
  end
end
