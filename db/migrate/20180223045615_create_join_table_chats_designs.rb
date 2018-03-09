class CreateJoinTableChatsDesigns < ActiveRecord::Migration[5.1]
  def change
    create_join_table :chats, :designs do |t|
      # t.index [:chat_id, :design_id]
      # t.index [:design_id, :chat_id]
    end
  end
end
