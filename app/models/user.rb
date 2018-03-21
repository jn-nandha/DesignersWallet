#desfine the relation of User model  to other model
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :designs
  has_many :favourites
  has_many :chats
  has_many :feedbacks
  has_many :followinglists
  belongs_to :city 


  def self.inactive_users
    User.where(activation: "false").pluck(:id)
  end


  def search_users(name)
    User.where("name LIKE ?","%#{name}%") - (User.where(id: self.blocked_users) + User.where(id: User.inactive_users) + [self])
  end

  def uploaded_designs
    Design.where(user_id: self.id)
  end

  def favourited_designs
    Design.where(id: Favourite.where(user_id: self.id).pluck(:design_id))
  end

  def uploaded_favourited_designs
    (self.uploaded_designs + self.favourited_designs).uniq
  end

  def messages_with(user)
    Chat.where("(sender_id =? and receiver_id= ?) or (sender_id =? and receiver_id=?)", self.id, user.id, user.id, self.id).order('created_at ASC')
  end

   def blocked_by_me
    User.where(id: FollowingList.blocked.where(from_id: self.id).pluck(:to_id))
  end

  def blocked_by_whom
    User.where(id: FollowingList.blocked.where(to_id: self.id).pluck(:from_id))
  end

  def blocked_users
    (self.blocked_by_me + self.blocked_by_whom ).uniq
  end

  def followers
    User.where(id: FollowingList.where(to_id: self.id).accepted.pluck(:from_id))
  end

  def followings
    User.where(id: FollowingList.where(from_id: self.id).accepted.pluck(:to_id))
  end  

   def requested_users
    User.where(id: FollowingList.where(to_id: self.id).requested.pluck(:from_id)) - self.blocked_by_me
  end
end
