module SessionsHelper

  # Sign in admin
  # Input: admin object
  # Output: admin with new remember token and now set as current_admin
  def sign_in(admin)
    cookies.permanent[:remember_token] = admin.remember_token
    self.current_admin = admin
  end

  # Output: boolean True if admin is signed in
  def signed_in?
    !current_admin.nil?
  end

  def current_admin=(admin)
    @current_admin = admin
  end

  def current_admin
    @current_admin ||= Admin.find_by_remember_token(cookies[:remember_token])
  end

  # Input: admin object
  # Output: boolean True if input is equal to current_admin
  def current_admin?(admin)
    admin == current_admin
  end

  # Sign out admin
  # remove admin's cookies and nullify current_admin
  def sign_out
    self.current_admin = nil
    cookies.delete(:remember_token)
  end

  # Returns boolean true if user has voted
  def voted
    session[:vote] = true
  end

end
