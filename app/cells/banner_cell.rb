class BannerCell < Cell::Rails

  def show(opts)
    @theme = opts[:theme]
    if @theme.banner.present?
      render
    end
  end

end
