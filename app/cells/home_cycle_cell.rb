class HomeCycleCell < Cell::Rails
  #before_filter :prepare_for_mobile, :only => :show
  
  def show(opts)
    @home_cycle_slides = HomeCycleSlide.sorted.all
    unless opts[:mobile]
      render
    else
      render :format => :mobile
    end
  end

end
