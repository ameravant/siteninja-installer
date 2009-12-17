# This controller handles the login/logout function of the site.  
class SessionsController < ApplicationController
  unloadable # http://dev.rubyonrails.org/ticket/6001
  before_filter :set_admin, :only => [ :new, :create ]

  def new    
  end

  def create
    self.current_user = User.authenticate(params[:login], params[:password])
    if logged_in?
      if params[:remember_me] == "1"
        current_user.remember_me unless current_user.remember_token?
        cookies[:auth_token] = { :value => self.current_user.remember_token , :expires => self.current_user.remember_token_expires_at }
      end
      flash[:error] = nil
      if session[:redirect]
        begin
          redirect_to session[:redirect]
        rescue
          redirect_to "/"
        end
      else
        redirect_to '/admin'
      end
    else
      flash[:error] = "Your account information could not be verified. Please try again."
      render :action => 'new'
    end
  end

  def destroy
    self.current_user.forget_me if logged_in?
    cookies.delete :auth_token
    reset_session
    flash[:notice] = "You have been logged out."
    redirect_to '/'
  end

  private
  
    def set_admin
      @admin = true
    end

end
