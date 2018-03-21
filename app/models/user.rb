class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,:recoverable, 
  :rememberable, :trackable, :validatable, :confirmable
  
  has_many :designs
  has_many :favourites
  has_many :chats
  has_many :feedbacks
  has_many :followinglists
  belongs_to :city 


end