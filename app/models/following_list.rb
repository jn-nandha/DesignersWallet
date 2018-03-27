# followingList model with other model realtion
class FollowingList < ApplicationRecord
  enum follow_status: %i[accepted requested blocked]
  belongs_to :to, class_name: 'User'
  belongs_to :from, class_name: 'User'

  def self.find_record(from,to)
  	FollowingList.where(from_id: from, to_id: to)
  end

end
