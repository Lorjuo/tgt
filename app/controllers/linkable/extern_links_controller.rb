module Linkable
  class ExternLinksController < BaseController
    load_and_authorize_resource # param_method: :resource_params

    include ::Linkable

    private

      def resource_params
        params.require(:extern_link).permit(:url, :link_attributes => [:id, :name, :parent_id, :department_id]) # Missing id column in permit statement can cause deadloops!!!
      end
  end
end