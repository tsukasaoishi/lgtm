class ImagesController < ApplicationController
  def cached_image
    image = Image.find(params[:id])
    send_data image.cached_image, type: image.content_type, disposition: 'inline'
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
