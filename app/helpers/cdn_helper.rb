module CdnHelper
  OFFLINE = (Rails.env.development? or Rails.env.test?)

  def jquery_datatables_include_tag(options = {})

    local_asset = '_datatables-bundle'
    cdn_asset = 'https://cdn.datatables.net/r/bs/dt-1.10.9,r-1.0.7/datatables.min.js'

    return javascript_include_tag(local_asset, options) if OFFLINE && !options.delete(:force)

    [ javascript_include_tag(cdn_asset, options),
        javascript_tag("$.fn.hasOwnProperty('DataTable') || document.write(unescape('#{javascript_include_tag(local_asset, options).gsub('<','%3C')}'))")
      ].join("\n").html_safe
  end
end