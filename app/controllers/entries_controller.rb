class EntriesController < ApplicationController
  before_action :require_login

  def new
    @place = current_user.places.find_by({ "id" => params["place_id"] })
    if @place.nil? # Handle the case where the place doesn't exist or doesn't belong to the user
      redirect_to places_path, notice: "Place not found"
    end
    @entry = Entry.new
  end

  def create
    @entry = current_user.entries.new(entry_params) 
    @entry.place_id = params["place_id"] 
    if @entry.save
      redirect_to "/places/#{@entry["place_id"]}"
    else
      render :new
    end
  end
  

  private

  def entry_params
    params.require(:entry).permit(:title, :description, :occurred_on, :image) 
  end
end