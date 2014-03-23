module ApplicationHelper
  # http://stackoverflow.com/questions/9772588/when-using-shallow-routes-different-routes-require-different-form-for-arguments
  def shallow_args(parent, child)
    child.try(:new_record?) ? [parent, child] : child
  end

  # http://andre.arko.net/2013/02/02/nested-layouts-on-rails--31/
  # or this for haml
  # http://stackoverflow.com/questions/8885651/switch-layout-columns-based-on-controller
  def inside_layout(parent_layout)
    view_flow.set :layout, capture { yield }
    render template: "layouts/#{parent_layout}"
  end

  # https://gist.github.com/jfriedlaender/1273614
  # ALternative: https://github.com/plashchynski/rgb
  # Amount should be a decimal between 0 and 1. Lower means darker
  def darken_color(hex_color, amount=0.4)
    hex_color = hex_color.gsub('#','')
    rgb = hex_color.scan(/../).map(&:hex).map{|color| color * amount}.map(&:round)
    "#%02x%02x%02x" % rgb
  end

  # Amount should be a decimal between 0 and 1. Higher means lighter
  def lighten_color(hex_color, amount=0.4)
    hex_color = hex_color.gsub('#','')
    rgb = hex_color.scan(/../).map(&:hex).map{|color| [(color + 255 * amount).round, 255].min}
    "#%02x%02x%02x" % rgb
  end

  def link_to_pill(name, path, options = {})
    content_tag :div, class: "pill" do
      link_to(name, path, options)
    end
  end

  def link_to_decent(name, path, options = {})
    options[:class] ? options[:class] += ' decent' : options[:class] = 'decent'
    link_to(name, path, options)
  end

end
