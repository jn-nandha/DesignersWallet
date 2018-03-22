class Design < ApplicationRecord
	has_and_belongs_to_many :categories
	belongs_to :user 
	has_many :favourites , dependent: :destroy
	has_many :feedbacks , dependent: :destroy
	mount_uploader :image, ImageUploader


	def favourited_by
		User.where(id: Favourite.where(design_id: self.id).pluck(:user_id))
	end

	def liked_by
		User.where(id: Feedback.where(design_id: self.id, like: "true").pluck(:user_id))
	end

	def complained_by
		User.where(id: Feedback.where('design_id = ? and report != ?',self.id,"NULL").pluck(:user_id))
	end

end
