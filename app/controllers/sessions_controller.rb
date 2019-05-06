require 'securerandom'

class SessionsController < ApplicationController
    def create
        if request.env["omniauth.auth"]
            #for omniauth generate securerand u.password = method_from securerand
            @user = User.find_or_create_by(uid: auth['uid']) do |u|
                u.name = auth['info']['name']
                u.email = auth['info']['email']
                u.password = SecureRandom.hex(13)
                u.password_confirmation = u.password
            end
    
            session[:user_id] = @user.id
            puts @user.id
            redirect_to account_path
        else
            @user = User.find_by(email: params[:email])
            if @user.try(:authenticate, params[:password])
                puts @user
                session[:user_id] = @user.id
                redirect_to account_path
            else
                flash[:alert] = "Username or Password Incorrect"
                redirect_to login_path
            end
        end
    end

    def destroy
        session.delete :user_id
        redirect_to root_path
    end

    private
    
    def auth
        request.env['omniauth.auth']
    end
end
