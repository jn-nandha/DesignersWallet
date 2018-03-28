# followingList model with other model realtion
class FollowingList < ApplicationRecord

  enum follow_status: %i[accepted requested blocked]
  belongs_to :to, class_name: 'User'
  belongs_to :from, class_name: 'User'
end
