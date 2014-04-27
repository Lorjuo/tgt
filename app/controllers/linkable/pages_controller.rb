module Linkable
  class PagesController < BaseController

    include ::LinkablesController

    private

      def resource_params
        params.require(:page).permit(:content,
        :gallery_ids => [], :document_ids => [], :link_attributes => [:id, :name, :active, :parent_id, :theme_id, :department_id]) # Missing id column in permit statement can cause deadloops!!!
      end
  end
end