class GoogleLoginApiController < ApplicationController
  require 'googleauth/id_tokens/verifier'
  
    protect_from_forgery except: :callback
    before_action :verify_g_csrf_token
  
    def callback
      payload = Google::Auth::IDTokens.verify_oidc(params[:credential], aud: '253764374707-qb38dbcujbto05dl95k9fkk7jmpa86ng.apps.googleusercontent.com')
      
      if user = User.find_by(email: payload['email'])
        session[:user_id] = user.id
        redirect_to root_path, success: t('.success')
      else
        user = User.new(email: payload['email'], name: 'name', password: 'password', password_confirmation: 'password')
        if user.save
          session[:user_id] = user.id
          redirect_to root_path, success: t('.reqire_change')
        else
          flash.now[:danger] = t('.fail')
          render :new, status: :unprocessable_entity
        end
      end
    end
  
    private
    
    def verify_g_csrf_token
      if cookies["g_csrf_token"].blank? || params[:g_csrf_token].blank? || cookies["g_csrf_token"] != params[:g_csrf_token]
        redirect_to root_path, danger: t('.unauthorized_access')
      end
    end
 end
