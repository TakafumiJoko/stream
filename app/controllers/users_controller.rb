class UsersController < ApplicationController
  before_action :check_logged_in
  def show
    @user = User.find(params[:id])
  end 
end
