class HomeCycleCell < Cell::Rails
  
  def show(opts)
    unless opts[:mobile]
      render
    else
      render :format => :mobile
    end
  end

end
