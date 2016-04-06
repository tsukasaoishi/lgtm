require 'open-uri'
require 'tempfile'

class Image < ActiveRecord::Base
  has_many :tags_images
  has_many :tags, through: :tags_images

  RESIZE_WIDTH = "480x480"

  def cached_image_and_type
    Rails.cache.fetch("#{self.class.name}_#{id}_cached_image_and_type") do
      read_image = open(url, "User-Agent" => "LGTM(https://github.com/tsukasaoishi/lgtm)")
      source_file = Tempfile.new("lgtm_source")
      source_file.binmode
      source_file.write read_image.read
      source_file.flush

      resize_file = Tempfile.new("lgtm_resize")
      resize_file.binmode
      `convert #{source_file.path} -coalesce -resize #{RESIZE_WIDTH} -deconstruct #{resize_file.path}`
      source_file.close
      resize_file.rewind
      data = resize_file.read
      resize_file.close

      [data, read_image.content_type]
    end
  end
end
