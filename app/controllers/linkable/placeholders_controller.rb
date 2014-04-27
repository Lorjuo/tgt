module Linkable
  class PlaceholdersController < BaseController

    include ::LinkablesController

    private

      def resource_params
        params.require(:placeholder).permit(:link_attributes => [:id, :name, :active, :parent_id, :theme_id, :department_id]) # Missing id column in permit statement can cause deadloops!!!
      end
  end
end