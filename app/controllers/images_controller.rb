class ImagesController < ApplicationController
  caches_action  :cached_image

  def index
    @images = Image.order("created_at DESC").limit(30)
  end

  def cached_image
    image = Image.find(params[:id])
    send_data image.cached_image, type: image.content_type, disposition: 'inline'
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
