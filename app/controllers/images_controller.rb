class ImagesController < ApplicationController
  def cached_image
    image = Image.find(params[:id])
    data, content_type = image.cached_image_and_type
    send_data data, type: content_type, disposition: 'inline'
  end

  def random
    @image = Image.random_pickup
    render :show
  end

  def show
    @image = Image.find(params[:id])
  end

  def new
    @image = Image.new
  end

  def create
    permit_params = params.require(:image).permit(:url)
    image = Image.create!(permit_params)
    redirect_to image
  end
end
