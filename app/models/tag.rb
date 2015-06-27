class Tag < ActiveRecord::Base
  has_many :tags_images
  has_many :images, through: :tags_images
end
