require 'cancan'


module Ckeditor
  module Hooks
    class CanCanAuthorization
      def authorize(action, model_object = nil)
        debugger
        @controller.authorize!(action.to_sym, model_object) if action
      end
    end
  end
end

Ckeditor::AUTHORIZATION_ADAPTERS[:cancan] = Ckeditor::Hooks::CanCanAuthorization