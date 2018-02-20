class CreateChats < ActiveRecord::Migration[5.1]
  def change
    create_table :chats do |t|
      t.text :message
      t.string :sender_status
      t.string :receiver_status
      t.references :sender
      t.references :receiver
      t.timestamps
    end
  end
end
