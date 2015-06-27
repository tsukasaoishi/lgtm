class Image < ActiveRecord::Base
  has_many :tags_images
  has_many :tags, through: :tags_images
end
