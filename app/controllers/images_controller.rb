class ImagesController < ApplicationController
  def index
    @images = Image.page(params[:page]).per(10).order("id desc")
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

  def destroy
    image = Image.find(params[:id])
    image.destroy

    redirect_to action: :index
  end
end
