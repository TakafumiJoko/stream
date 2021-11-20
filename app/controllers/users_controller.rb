class UsersController < ApplicationController
  skip_before_action :check_logged_in, only: [:show]
  def show
    @user = User.find_by(params[:id])
  end 
end
