class RawDataController < ApplicationController
  def show
    image = Image.find(params[:id])
    data, content_type = image.cached_image_and_type

    send_data data, type: content_type, disposition: 'inline'
  end
end
