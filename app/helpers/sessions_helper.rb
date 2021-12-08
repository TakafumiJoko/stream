module SessionsHelper
  def current_user
    return unless (user_id = session[:user_id])

    @current_user ||= User.find_by(id: user_id)
  end
 
  def log_in
    if session[:user_id]
      @user = User.find_by(id: session[:user_id]) 
    else
      @user = User.create
      @user.update(
        name: "ゲスト#{@user.id}",
        email: "guest#{@user.id}@example.com",
        password: SecureRandom.urlsafe_base64
      )
      channel = @user.channels.build(name: @user.name)
      channel.save
    end
    session[:user_id] = @user.id
    binding.pry
  end

  def log_out
    session.delete(:user_id)
    @current_user = nil
  end
end
