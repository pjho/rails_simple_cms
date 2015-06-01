module ApplicationHelper
  
  def adminIsSudo?
    return current_admin.sudo
  end

end
