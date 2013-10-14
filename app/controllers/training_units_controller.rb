class TrainingUnitsController < ApplicationController
  before_action :set_training_unit, only: [:show, :edit, :update, :destroy]

  # GET /training_units
  # GET /training_units.json
  def index
    @training_units = TrainingUnit.all
  end

  # GET /training_units/1
  # GET /training_units/1.json
  def show
  end

  # GET /training_units/new
  def new
    @training_unit = TrainingUnit.new
  end

  # GET /training_units/1/edit
  def edit
  end

  # POST /training_units
  # POST /training_units.json
  def create
    @training_unit = TrainingUnit.new(training_unit_params)

    respond_to do |format|
      if @training_unit.save
        format.html { redirect_to @training_unit, notice: 'Training unit was successfully created.' }
        format.json { render action: 'show', status: :created, location: @training_unit }
      else
        format.html { render action: 'new' }
        format.json { render json: @training_unit.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /training_units/1
  # PATCH/PUT /training_units/1.json
  def update
    respond_to do |format|
      if @training_unit.update(training_unit_params)
        format.html { redirect_to @training_unit, notice: 'Training unit was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @training_unit.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /training_units/1
  # DELETE /training_units/1.json
  def destroy
    @training_unit.destroy
    respond_to do |format|
      format.html { redirect_to training_units_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_training_unit
      @training_unit = TrainingUnit.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def training_unit_params
      params.require(:training_unit).permit(:weekday, :time_begin, :time_end, :location_summer_id, :location_winter_id)
    end
end
