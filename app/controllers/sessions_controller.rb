class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
   if user && user.authenticate(params[:session][:password])
    if user.activated?
      log_in user
      params[:session][:remember_me] == "1" ? remember(user) : forget(user)
      redirect_back_or user
    else
      message = "Tài khoản chưa được kích hoạt. Vui lòng kiểm tra email để kích hoạt tài khoản."
      flash[:success] = message
      redirect_to root_url
    end
    else
      flash.now[:success] = "Vui lòng nhập tên đăng nhập /mật khẩu đăng nhập"
      render 'new'
    end
  end

  def destroy
    log_out
   
    redirect_to help_path
  end
end
