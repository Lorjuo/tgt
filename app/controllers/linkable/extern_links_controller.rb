module Linkable
  class ExternLinksController < BaseController

    include ::LinkablesController

    private

      def resource_params
        params.require(:extern_link).permit(:url, :link_attributes => [:id, :name, :active, :parent_id, :theme_id, :department_id]) # Missing id column in permit statement can cause deadloops!!!
      end
  end
end