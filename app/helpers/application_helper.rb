module ApplicationHelper
  # http://stackoverflow.com/questions/9772588/when-using-shallow-routes-different-routes-require-different-form-for-arguments
  def shallow_args(parent, child)
    child.try(:new_record?) ? [parent, child] : child
  end
end
