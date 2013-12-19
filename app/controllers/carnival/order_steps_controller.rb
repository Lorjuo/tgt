class Carnival::OrderStepsController < ApplicationController
  include Wicked::Wizard

  #load_and_authorize_resource
  skip_authorization_check

  layout 'two_columns'

  steps :personal_information, :sessions, :notices

  def create
    @order = Carnival::Order.create
    @order.build_person
    @order.build_reservation
    @order.save! :validate => false
    Rails.logger.info @order.id
    redirect_to wizard_path(steps.first, :order_id => @order.id)
  end

  def show
    @order = Carnival::Order.find(params[:order_id])
    render_wizard
  end

  def update
    @order = Carnival::Order.find(params[:order_id])
    @order.update_attributes!(carnival_order_steps_params)
    # case step
    # when :sessions
    # end
    render_wizard @order
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def carnival_order_steps_params
      params.require(:carnival_order).permit(:notice,
        :person_attributes => [:first_name, :last_name, :street, :zip, :city, :email, :phone],
        :reservations_attributes => [:id, :session_id, :category_id, :amount, :_destroy] )
    end

    def finish_wizard_path
      # @order = Carnival::Order.find(params[:order_id])
      root_path
    end
end
