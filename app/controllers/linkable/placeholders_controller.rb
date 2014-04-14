module Linkable
  class PlaceholdersController < BaseController
    load_and_authorize_resource # param_method: :resource_params

    include ::Linkable

    private

      def resource_params
        params.require(:placeholder).permit(:link_attributes => [:id, :name, :active, :parent_id, :department_id]) # Missing id column in permit statement can cause deadloops!!!
      end
  end
end