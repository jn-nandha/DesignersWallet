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


  def self.inactive_id_list
    User.where(activation: "false").pluck(:id)
  end


  def search_users(name)
    User.where("name LIKE ?","%#{name}%") - (User.where(id: self.blocked_ids) + User.where(id: User.inactive_id_list) + [self])
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

  def blocked_to
    User.where(id: FollowingList.blocked.where(from_id: self.id).pluck(:to_id))
  end

  def blocked_by
    User.where(id: FollowingList.blocked.where(to_id: self.id).pluck(:from_id))
  end

  def blocked_ids
    (self.blocked_to.pluck(:id) + self.blocked_by.pluck(:id)).uniq
  end

  def followers
    User.where(id: FollowingList.where(from_id: self.id).accepted.pluck(:to_id))
  end

  def followings
    User.where(id: FollowingList.where(to_id: self.id).accepted.pluck(:from_id))
  end  
  
end
