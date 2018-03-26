# devise admin model validation
class Admin < ApplicationRecord
  # devise :database_authenticatable, :registerable,
  #        :recoverable, :rememberable, :trackable, :validatable, :confirmable
 devise :database_authenticatable, :trackable, :timeoutable, :lockable 

end
