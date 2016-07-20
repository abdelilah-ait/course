class UsersController < ApplicationController
  def home	
  end

  def login
  	if session[:user_id]
  		redirect_to users_home_path
  	end
  end

  def logout
  	session[:user_id] = nil
  	redirect_to users_login_path
  end

  def index
  	if !@current_user.try(:admin?)
      flash[:error] = "Accès interdit"
    else
    	@users= User.all
    end
  end

  def check
  	@current_user = User.find_by(name: params[:name])

  	if @current_user && @current_user.authenticate(params[:password])
  		session[:user_id] = @current_user.id
  		flash[:info] = "Vous êtes maintenant connecté"
  		redirect_to users_home_path 
	else
		flash[:info] = "Échec de la connexion"
  		redirect_to users_login_path
	end  
  end
end
