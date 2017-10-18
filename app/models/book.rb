class Book < ApplicationRecord
  mount_uploader :image, PictureUploader
  has_many :reviews, dependent: :destroy
end
