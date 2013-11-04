class LocationsController < ApplicationController
  before_action :set_location, only: [:show, :edit, :update, :destroy]

  load_and_authorize_resource

  # GET /locations
  # GET /locations.json
  def index
    @locations = Location.all
  end

  def interactive_map
    @loactions_with_geodata = Location.all.where( "latitude <> ''" ).where( "longitude <> ''" )
    @geodata = Gmaps4rails.build_markers(@loactions_with_geodata) do |location, marker|
      #https://github.com/apneadiving/Google-Maps-for-Rails/wiki/Json-builder
      # https://github.com/apneadiving/Google-Maps-for-Rails/blob/master/vendor/assets/javascripts/gmaps/google/builders/marker.coffee
      marker.lat location.latitude
      marker.lng location.longitude
      marker.title location.name
      marker.infowindow render_to_string(:partial => "/locations/info", :locals => { :location => location})
    end
  end

  # GET /locations/1
  # GET /locations/1.json
  def show
  end

  # GET /locations/new
  def new
    @location = Location.new
  end

  # GET /locations/1/edit
  def edit
  end

  # POST /locations
  # POST /locations.json
  def create
    @location = Location.new(location_params)

    respond_to do |format|
      if @location.save
        format.html { redirect_to @location, notice: 'Location was successfully created.' }
        format.json { render action: 'show', status: :created, location: @location }
      else
        format.html { render action: 'new' }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /locations/1
  # PATCH/PUT /locations/1.json
  def update
    respond_to do |format|
      if @location.update(location_params)
        format.html { redirect_to @location, notice: 'Location was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /locations/1
  # DELETE /locations/1.json
  def destroy
    @location.destroy
    respond_to do |format|
      format.html { redirect_to locations_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_location
      @location = Location.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def location_params
      params.require(:location).permit(:name, :address, :latitude, :longitude)
      # TOOD: delete latitude and longitude
    end
end
