class Book < ApplicationRecord
  mount_uploader :image, PictureUploader
end
