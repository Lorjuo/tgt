class ShortRoutesController < ApplicationController
  before_action :set_short_route, only: [:show, :edit, :update, :destroy]

  load_and_authorize_resource

  layout "two_columns"

  # GET /short_routes
  # GET /short_routes.json
  def index
    @short_routes = ShortRoute.all
  end

  # GET /short_routes/1
  # GET /short_routes/1.json
  def show
  end

  # GET /short_routes/new
  def new
    @short_route = ShortRoute.new
  end

  # GET /short_routes/1/edit
  def edit
  end

  # POST /short_routes
  # POST /short_routes.json
  def create
    @short_route = ShortRoute.new(short_route_params)

    respond_to do |format|
      if @short_route.save
        format.html { redirect_to @short_route, notice: 'Short route was successfully created.' }
        format.json { render action: 'show', status: :created, location: @short_route }
      else
        format.html { render action: 'new' }
        format.json { render json: @short_route.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /short_routes/1
  # PATCH/PUT /short_routes/1.json
  def update
    respond_to do |format|
      if @short_route.update(short_route_params)
        format.html { redirect_to @short_route, notice: 'Short route was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @short_route.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /short_routes/1
  # DELETE /short_routes/1.json
  def destroy
    @short_route.destroy
    respond_to do |format|
      format.html { redirect_to short_routes_url }
      format.json { head :no_content }
    end
  end

  def redirect
    @short_route = ShortRoute.find_by!(name: params[:name])
    redirect_to @short_route.url, :status => @short_route.http_status
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_short_route
      @short_route = ShortRoute.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def short_route_params
      params.require(:short_route).permit(:name, :url, :http_status)
    end
end
