class FollowingList < ApplicationRecord
	belongs_to :user , foreign_key: "to_id"
	belongs_to :user , foreign_key: "from_id"
end
