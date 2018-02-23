class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
  has_many :designs
  has_many :favourites
  has_many :chats
  has_many :feedbacks
  has_many :followinglists
  belongs_to :city 
<<<<<<< HEAD
=======

   has_secure_password
 
  has_many :assignments
  has_many :roles, through: :assignments

  
>>>>>>> f76ffd52b579afa948ebecdf93edaa51ee39b8f5
end
