class Carnival::SessionsController < ApplicationController
  before_action :set_carnival_session, only: [:show, :edit, :update, :destroy]

  load_and_authorize_resource

  layout 'two_columns'

  # GET /carnival/sessions
  # GET /carnival/sessions.json
  def index
    @carnival_sessions = Carnival::Session.all
  end

  # GET /carnival/sessions/1
  # GET /carnival/sessions/1.json
  def show
  end

  # GET /carnival/sessions/new
  def new
    @carnival_session = Carnival::Session.new
  end

  # GET /carnival/sessions/1/edit
  def edit
  end

  # POST /carnival/sessions
  # POST /carnival/sessions.json
  def create
    @carnival_session = Carnival::Session.new(carnival_session_params)

    respond_to do |format|
      if @carnival_session.save
        format.html { redirect_to @carnival_session, notice: 'Session was successfully created.' }
        format.json { render action: 'show', status: :created, location: @carnival_session }
      else
        format.html { render action: 'new' }
        format.json { render json: @carnival_session.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /carnival/sessions/1
  # PATCH/PUT /carnival/sessions/1.json
  def update
    respond_to do |format|
      if @carnival_session.update(carnival_session_params)
        format.html { redirect_to @carnival_session, notice: 'Session was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @carnival_session.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /carnival/sessions/1
  # DELETE /carnival/sessions/1.json
  def destroy
    @carnival_session.destroy
    respond_to do |format|
      format.html { redirect_to carnival_sessions_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_carnival_session
      @carnival_session = Carnival::Session.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def carnival_session_params
      params.require(:carnival_session).permit(:name, :term, :category_ids => [])
    end
end
