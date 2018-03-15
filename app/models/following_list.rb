class FollowingList < ApplicationRecord
	enum follow_status: [:accepted, :requested, :blocked]
	belongs_to :to , class_name: "User"
	belongs_to :from , class_name: "User"
end

