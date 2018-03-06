class Chat < ApplicationRecord
	enum message_status: [:read, :unread]
	enum message_type: [:text, :image]
	serialize :designs_id, Array

	belongs_to :sender , class_name: "User"
	belongs_to :receiver , class_name: "User"
	has_and_belongs_to_many :designs, dependent: :destroy
end
