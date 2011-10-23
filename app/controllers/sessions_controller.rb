class SessionsController < ApplicationController
  
  def new
    if session[:admin_id] != nil
      redirect_to admins_index_url
    end
  end

  def create
    admin = Admin.authenticate(params[:email], params[:password])
    if admin
      session[:admin_id] = admin.id
      redirect_to admins_index_url
    else
      flash.now.alert = "Invalid email or password"
      render "new"
    end
  end

  def destroy
    session[:admin_id] = nil
    redirect_to log_in_url, :notice => "Logged out!"
  end

end
