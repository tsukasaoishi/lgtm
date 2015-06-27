require 'open-uri'

class Image < ActiveRecord::Base
  has_many :tags_images
  has_many :tags, through: :tags_images

  def cached_image
    read_image = open(url, "User-Agent" => "LGTM(https://github.com/tsukasaoishi/lgtm)")
    @content_type = read_image.content_type
    read_image.read
  end

  def content_type
    @content_type || "image/jpeg"
  end
end
