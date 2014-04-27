class StylesheetCell < Cell::Base # Change back to Cell::Rails

  # http://spin.atomicobject.com/2013/12/21/dynamically-generate-css/
  # TODO: cache this
  def show(opts)
    scss = render_to_string("show", locals: {
      color: opts[:color]
    }, formats: :scss)
   
    css = Sass::Engine.new(scss, syntax: :scss).render
   
    render text: css, content_type: Mime::CSS
  end

end
