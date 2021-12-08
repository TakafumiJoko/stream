module SessionsHelper
  def current_user
    return unless (user_id = session[:user_id])

    @current_user ||= User.find_by(id: user_id)
  end
  
  def guest_log_in
    if cookies[:user_id]
      user = User.find_by(id: cookies[:user_id]) 
    else
      user = User.create
      user.update_attributes(
        name: "ゲスト#{user.id}",
        email: "guest#{user.id}@example.com",
        password: SecureRandom.urlsafe_base64
      )
      channel = user.channels.build(name: user.name)
      channel.save
    end
    log_in user
  end
  
  def log_in(user)
    cookies[:user_id] = user.id
  end

  def log_out
    cookies.delete(:user_id)
    @current_user = nil
  end
end
