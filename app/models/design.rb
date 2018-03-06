class Design < ApplicationRecord
	has_and_belongs_to_many :categories, dependent: :destroy
	has_and_belongs_to_many :chats, dependent: :destroy
	belongs_to :user 
	has_many :favourites, dependent: :destroy
	has_many :feedbacks 
	mount_uploader :image, ImageUploader
end
