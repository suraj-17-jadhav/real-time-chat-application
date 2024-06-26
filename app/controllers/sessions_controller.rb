class SessionsController < ApplicationController

    before_action :logged_in_redirect, only: [:new, :create]
    
    def new

    end

    def create
        client = Client.find_by(username: params[:session][:username])
        if client && client.authenticate(params[:session][:password])
          session[:client_id] = client.id
          flash[:success] = "You have successfully logged in"
          redirect_to root_path
        else
          flash.now[:error] = "There was something wrong with your login information"
          render 'new'
        end 
    end

    def destroy
        session[:client_id] = nil
        flash[:success] = "You have successfully logged out"
        redirect_to login_path
    end

    private

    def logged_in_redirect
      if logged_in?
        flash[:error] = "You are already logged in"
        redirect_to root_path
      end
    end

end