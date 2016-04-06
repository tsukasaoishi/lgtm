require 'open-uri'

class Image < ActiveRecord::Base
  has_many :tags_images
  has_many :tags, through: :tags_images

  def cached_image_and_type
    Rails.cache.fetch("#{self.class.name}_#{id}_cached_image_and_type") do
      read_image = open(url, "User-Agent" => "LGTM(https://github.com/tsukasaoishi/lgtm)")
      [read_image.read, read_image.content_type]
    end
  end
end
