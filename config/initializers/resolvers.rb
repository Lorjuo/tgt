# https://github.com/rails/rails/issues/3855
# alternatives:
# http://stackoverflow.com/questions/4062518/can-a-mobile-mime-type-fall-back-to-html-in-rails
# http://stackoverflow.com/questions/8863257/changing-view-formats-in-rails-3-1-delivering-mobile-html-formats-fallback-on/9493617#9493617

module Resolvers
  # this resolver graciously shared by jdelStrother at
  # https://github.com/rails/rails/issues/3855#issuecomment-5028260
  class MobileFallbackResolver < ::ActionView::FileSystemResolver
    def find_templates(name, prefix, partial, details)
      if details[:formats] == [:mobile]
        # Add a fallback for html, for the case where, eg, 'index.html.haml' exists, but not 'index.mobile.haml'
        details = details.dup
        details[:formats] = [:mobile, :html]
      end
      super
    end
  end
end

ActiveSupport.on_load(:action_controller) do
  tmp_view_paths = view_paths.dup # avoid endless loop as append_view_path modifies view_paths
  tmp_view_paths.each do |path|
    append_view_path(Resolvers::MobileFallbackResolver.new(path.to_s))
  end
end