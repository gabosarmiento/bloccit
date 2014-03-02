class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end 

  #The method returns topics_path, which will display the topics/index.html.erb view.
  def after_sign_in_path_for(resource)
    topics_path
  end  

  #Keeping user on the same page after signing out
  def after_sign_out_path_for(resource_or_scope)
  request.referrer 
end

end
