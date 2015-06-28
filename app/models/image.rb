require 'open-uri'

class Image < ActiveRecord::Base
  has_many :tags_images
  has_many :tags, through: :tags_images

  after_save :flush_ids

  class << self
    def random_pickup
      find(ids.sample)
    end

    def flush_ids
      @ids = nil
    end

    private

    def ids
      @ids ||= pluck(:id)
    end
  end

  def cached_image
    read_image = open(url, "User-Agent" => "LGTM(https://github.com/tsukasaoishi/lgtm)")
    @content_type = read_image.content_type
    read_image.read
  end

  def content_type
    @content_type || "image/jpeg"
  end

  private

  def flush_ids
    self.class.flush_ids
  end
end
