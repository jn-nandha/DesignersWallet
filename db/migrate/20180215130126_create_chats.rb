class CreateChats < ActiveRecord::Migration[5.1]
  def change
    create_table :chats do |t|
      t.references :sender
      t.references :receiver
      t.integer :message_status
      t.integer :message_type
      t.text :body
      t.text :designs_id
      t.timestamps
    end
  end
end