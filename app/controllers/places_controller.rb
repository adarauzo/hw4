class PlacesController < ApplicationController
  before_action :require_login, except: [:index] 

  def index
    @places = current_user.places 
  end

  def show
    @place = current_user.places.find_by({ "id" => params["id"] }) 
    @entries = @place.entries 
    if @place.nil? 
      redirect_to places_path, notice: "Place not found"
    end
  end

  def new
    @place = Place.new
  end

  def create
    @place = current_user.places.new(place_params) 
    if @place.save
      redirect_to "/places"
    else
      render :new
    end
  end

  private

  def place_params
    params.require(:place).permit(:name)
  end
end