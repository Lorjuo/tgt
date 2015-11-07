class HomeCycleCell < Cell::Rails
  #before_filter :prepare_for_mobile, :only => :show
  
  def show(opts)
    unless opts[:mobile]
      render
    else
      render :format => :mobile
    end
  end

end
