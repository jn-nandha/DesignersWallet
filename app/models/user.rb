# defines the relation of User model  to other model
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :designs
  has_many :favourites
  has_many :chats
  has_many :feedbacks
  has_many :followed_by_me, class_name: 'FollowingList', foreign_key: 'from_id'
  has_many :followed_by_other, class_name: 'FollowingList', foreign_key: 'to_id'
  belongs_to :city 

  #Class Method
  # Give inactive users
  def self.inactive_users
    User.where(activation: false)
  end

  #Instance Method
  #Search functionality
  def search_users(name)
    User.where("name LIKE ?","#{name}%") - (self.blocked_users + User.inactive_users + [self])
  end

  #Design related method
  
  def all_designs
    Design.where(user_id: (self.search_users("").pluck(:id) + [self.id])).order("updated_at DESC")
  end

  def uploaded_designs
    Design.where(user_id: self.id)
  end

  def favourited_designs
    Design.where(id: Favourite.where(user_id: self.id).pluck(:design_id))
  end

  def followings_designs
    Design.where(user_id: self.followings.pluck(:id)).order("updated_at DESC")
  end

  def uploaded_favourited_designs
    (self.uploaded_designs + self.favourited_designs).uniq
  end

  #Chat related method
  def messages_with(user)
    Chat.where("(sender_id =? and receiver_id= ?) or (sender_id =? and receiver_id=?)", self.id, user.id, user.id, self.id).order('created_at ASC')
  end

  def notified_users
    User.where(id: Chat.where(receiver_id: self.id).unread.pluck(:sender_id).uniq) - self.invalid_users
  end

  def chated_users
    to = Chat.where(sender_id: self.id).pluck(:receiver_id).uniq
    from =  Chat.where(receiver_id: self.id).pluck(:sender_id).uniq
    User.where(id: (to + from).uniq)
  end




  #Favourite Design
  def favourited(design_id)
    Favourite.find_by(user_id: self.id, design_id: design_id)
  end

  def favourite?(design_id)
    Favourite.find_by(user_id: self.id, design_id: design_id).present?
  end

  #Feedback related method
  def feedback(design_id)
    Feedback.find_by(user_id: self.id, design_id: design_id)
  end

  


  #Follow related method
  def blocked_by_me
    User.where(id: followed_by_me.blocked.pluck(:to_id))
  end

  def blocked_by_whom
    User.where(id: followed_by_other.blocked.pluck(:from_id))
  end

  def blocked_users
    (self.blocked_by_me + self.blocked_by_whom).uniq
  end

  def followers
    User.where(id: followed_by_other.accepted.pluck(:from_id)) - self.invalid_users
  end

  def followings
    User.where(id: followed_by_me.accepted.pluck(:to_id)) - self.invalid_users
  end

  def invalid_users
    self.blocked_users + User.inactive_users
  end

  def requested_users
    User.where(id: followed_by_other.requested.pluck(:from_id)) - self.invalid_users
  end

  def requested_by_me
    User.where(id: followed_by_me.requested.pluck(:to_id)) - self.invalid_users
  end

  def follow_requested?(user)
    FollowingList.requested.find_by(from_id: self.id, to_id: user.id).present?
  end

  def follow_accepted?(user)
    FollowingList.accepted.find_by(from_id: self.id, to_id: user.id).present?
  end

  def follow_blocked?(user)
    FollowingList.blocked.find_by(from_id: self.id, to_id: user.id).present?
  end

end
