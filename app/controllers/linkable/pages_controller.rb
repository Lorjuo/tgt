# encoding: utf-8

module Linkable
  class PagesController < BaseController

    load_and_authorize_resource :find_by => :slug

    include ::LinkablesController

    include EmailHelper

    def show
      @linkable.content = save_email(@linkable.content)
    end

    private

      def resource_params
        params.require(:page).permit(:content, :sidebar,
        :gallery_ids => [], :document_ids => [], :link_attributes => [:id, :name, :active, :parent_id, :theme_id, :department_id]) # Missing id column in permit statement can cause deadloops!!!
      end

      def load_linkable
        @linkable = @model.friendly.find(params[:id])
      end

      def resolve_layout
        if @page.present? && !@page.sidebar && params[:action] == 'show'
          'one_column'
        else
          'two_columns'
        end

      end
  end
end