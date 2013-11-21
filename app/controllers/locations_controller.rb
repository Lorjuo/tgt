require 'column'

class LocationsController < ApplicationController
  before_action :set_location, only: [:show, :edit, :update, :destroy]

  load_and_authorize_resource

  layout :resolve_layout

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

  def schedule
    @season = params[:season] || "summer"
    @week_day = params[:week_day]
    if @season == "summer"
      training_units = @location.training_units_summer
    else
      training_units = @location.training_units_winter
    end
    schedule_data(training_units)
  end


  def new
    @location = Location.new
    @location.build_image
  end


  def edit
    @location.build_image unless @location.image.present?
  end


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
      params.require(:location).permit(:name, :address, :description, :image_attributes => [:file, :id])
      # TOOD: delete latitude and longitude
    end


    def schedule_data(training_units)
      @data = {}
      for day in 1..7

        # Reset reference time
        occupied_until = Time.zone.local(2000,1,1,0,0)

        if(@week_day.nil? || @week_day.to_i == day%7)

          # Init columns array for each day
          columns = @data[day%7] = Array.new
          
          # Init at least one column per day
          columns << Column.new
          
          training_units.week_day(day%7).chronological_time.each do |training_unit|
            
            added = false

            columns.each do |column|
              if column.append training_unit
                added = true
                break
              end
            end

            unless added
              column = Column.new
              column.append training_unit
              columns << column
            end
          end
        end
      end
    end

    def resolve_layout
      case action_name
      when "schedule"
        "one_column"
      else
        "two_columns"
      end
    end
end
