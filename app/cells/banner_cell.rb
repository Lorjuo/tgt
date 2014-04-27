class BannerCell < Cell::Rails

  def show(opts)
    @theme = opts[:theme]
    render
  end

end
