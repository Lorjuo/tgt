class NavigationCell < Cell::Rails
  helper TheSortableTreeHelper

  def show(opts)
    @department = opts[:department]
    render
  end

end
