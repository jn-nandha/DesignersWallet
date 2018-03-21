class Design < ApplicationRecord
  has_and_belongs_to_many :categories
  belongs_to :user
  has_many :favourites, dependent: :destroy
  has_many :feedbacks, dependent: :destroy
  mount_uploader :image, ImageUploader
end
