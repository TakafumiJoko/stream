class SessionsController < ApplicationController
  
  skip_before_action :check_logged_in, only: :create
  
  def create
    log_in
    redirect_to root_path
  end
   
  def destroy
    log_out
    redirect_to root_path
  end
end
