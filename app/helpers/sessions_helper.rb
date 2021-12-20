module SessionsHelper
  def current_user
    return unless (user_id = session[:user_id])
    @current_user ||= User.find_by(id: user_id)
  end
  
  def guest_log_in
    unless @user = User.find_by(id: session[:user_id]) 
      @user = User.create
      @user.update(
        name: "ゲスト#{@user.id}",
        email: "guest#{@user.id}@example.com",
        password: SecureRandom.urlsafe_base64
      )
      channel = @user.channels.build(name: @user.name)
      channel.save
    end
    log_in @user
  end

  def log_in(user)
    session[:user_id] = user.id
    @current_user = user
  end
  
  def log_out
    session.delete(:user_id)
    @current_user = nil
  end
  
end
