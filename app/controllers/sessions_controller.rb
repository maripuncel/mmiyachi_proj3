class SessionsController < ApplicationController

  def create
    admin = Admin.find_by_email(params[:session][:email].downcase)
    if admin && admin.authenticate(params[:session][:password])
      sign_in admin
      redirect_to admin
    else
      render 'new'
    end
  end

  def new
  end

  def destroy
    sign_out
    redirect_to root_url
  end

end
