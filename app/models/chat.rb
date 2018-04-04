class Chat < ApplicationRecord

  enum message_status: %i[read unread]
  enum message_type: %i[text image]
  serialize :designs_id, Array
  belongs_to :sender, class_name: 'User'
  belongs_to :receiver, class_name: 'User'
 
	def designs
		Design.where(id: Chat.find(self.id).designs_id)
	end

end
