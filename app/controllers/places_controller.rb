class PlacesController < ApplicationController
  before_action :set_place, only: [:show, :edit, :update, :destroy]
  layout "map", only: [:map]
  # GET /places
  # GET /places.json

  def map
    @places = Place.all
    @places.each do |p|
      puts p.id
      if p.lat == p.lng
        puts "conversion de coordonnées"
        if p.address == "" && p.deg_coordinates != nil
          deg = p.deg_coordinates
          lat = deg.split(", ").first
          lng = deg.split(", ").second

          degrees = lat.split("°").first
          minutes = lat.split("°").second.split("'").first
          seconds = lat.split("'").second
          decimal = ((minutes.to_f * 60)+seconds.to_f) / (60*60)
          p.lat = degrees.to_f + decimal
          puts lat

          degrees = lng.split("°").first
          minutes = lng.split("°").second.split("'").first
          seconds = lng.split("'").second
          decimal = ((minutes.to_f * 60)+seconds.to_f) / (60*60)
          p.lng = degrees.to_f + decimal
          puts lng
        else
          puts "on encode"
          p.lat = Geocoder.coordinates(p.address)[0]
          p.lng = Geocoder.coordinates(p.address)[1]
        end
        p.save
      end
    end
    @place = Place.new
  end

  def index
    @places = Place.all
  end

  # GET /places/1
  # GET /places/1.json
  def show
  end

  # GET /places/new
  def new
    @place = Place.new
  end

  # GET /places/1/edit
  def edit
  end

  # POST /places
  # POST /places.json
  def create
    @place = Place.new(place_params)

    respond_to do |format|
      if @place.save
        format.html { redirect_to @place, notice: 'Place was successfully created.' }
        format.json { render :show, status: :created, location: @place }
      else
        format.html { render :new }
        format.json { render json: @place.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /places/1
  # PATCH/PUT /places/1.json
  def update
    respond_to do |format|
      if @place.update(place_params)
        format.html { redirect_to itineraries_path, notice: 'Place was successfully updated.' }
        format.json { render :show, status: :ok, location: @place }
      else
        format.html { render :edit }
        format.json { render json: @place.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /places/1
  # DELETE /places/1.json
  def destroy
    @place.destroy
    respond_to do |format|
      format.html { redirect_to places_url, notice: 'Place was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_place
      @place = Place.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def place_params
      params.require(:place).permit(:label, :address, :deg_coordinates, :photo_url, :status, :lat, :lng, :itinerary_id)
    end
end
