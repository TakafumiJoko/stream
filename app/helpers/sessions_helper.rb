module SessionsHelper
  def current_user
    return unless (user_id = session[:user_id])

    @current_user ||= User.find_by(id: user_id)
  end
  
  def guest_log_in
    user = User.find_or_create_by!(email: 'guest@example.com') do |user|
      user.name = "ゲスト"
      user.password = SecureRondom.urlsafe_base64
      channel = user.channels.build(name: user.name)
      channel.save
    end
    log_in user
  end
  
  def log_in(user)
    session[:user_id] = user.id
  end

  def log_out
    session.delete(:user_id)
    @current_user = nil
  end
end
