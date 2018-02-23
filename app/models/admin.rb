class Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable 
<<<<<<< HEAD

         
=======
>>>>>>> f76ffd52b579afa948ebecdf93edaa51ee39b8f5
end
