# followingList model with other model realtion
class FollowingList < ApplicationRecord
  enum follow_status: %i[accepted requested blocked]
  belongs_to :to, class_name: 'User'
  belongs_to :from, class_name: 'User'



  def self.delete_follow(id1,id2)
    follow = FollowingList.find_by('from_id = ? and to_id = ?',id1,id2)
    FollowingList.destroy(follow.id)
  end

end
