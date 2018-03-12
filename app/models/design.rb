class Design < ApplicationRecord
	has_and_belongs_to_many :categories
	belongs_to :user 
	has_many :favourites
	has_many :feedbacks 
	mount_uploader :image, ImageUploader
end
