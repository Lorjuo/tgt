class Carnival::ReservationsController < ApplicationController
  before_action :set_carnival_reservation, only: [:show, :edit, :update, :destroy]

  load_and_authorize_resource

  layout 'two_columns'

  # GET /carnival/reservations
  # GET /carnival/reservations.json
  def index
    @carnival_reservations = Carnival::Reservation.all
  end

  # GET /carnival/reservations/1
  # GET /carnival/reservations/1.json
  def show
  end

  # GET /carnival/reservations/new
  def new
    @carnival_reservation = Carnival::Reservation.new
  end

  # GET /carnival/reservations/1/edit
  def edit
  end

  # POST /carnival/reservations
  # POST /carnival/reservations.json
  def create
    @carnival_reservation = Carnival::Reservation.new(carnival_reservation_params)

    respond_to do |format|
      if @carnival_reservation.save
        format.html { redirect_to @carnival_reservation, notice: 'Reservation was successfully created.' }
        format.json { render action: 'show', status: :created, location: @carnival_reservation }
      else
        format.html { render action: 'new' }
        format.json { render json: @carnival_reservation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /carnival/reservations/1
  # PATCH/PUT /carnival/reservations/1.json
  def update
    respond_to do |format|
      if @carnival_reservation.update(carnival_reservation_params)
        format.html { redirect_to @carnival_reservation, notice: 'Reservation was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @carnival_reservation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /carnival/reservations/1
  # DELETE /carnival/reservations/1.json
  def destroy
    @carnival_reservation.destroy
    respond_to do |format|
      format.html { redirect_to carnival_reservations_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_carnival_reservation
      @carnival_reservation = Carnival::Reservation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def carnival_reservation_params
      params.require(:carnival_reservation).permit(:order_id, :session_id, :category_id, :amount)
    end
end
