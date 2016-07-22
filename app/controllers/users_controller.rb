class UsersController < ApplicationController
  def home	
  end

  def login
  	if session[:user_id]
  		redirect_to users_home_path
  	end
  end

  def registre
    @newuser = User.new
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
  	@current_user = User.find_by(email: params[:email])

  	if @current_user && @current_user.authenticate(params[:password])
  		connect(@current_user) 
	  else
		  flash[:info] = "Échec de la connexion"
  		redirect_to users_login_path
	end  
  end

  def create
    if params[:password] == params[:password_confirmation]

      @newuser = User.new name: params[:name],  email: params[:email], password: params[:password]
      if @newuser.save
        connect(@newuser)
      else
        render "registre"
      end
    else
      flash[:info] = "password confirmation invalid"
      render "registre"
    end
  end

  private

    def connect(user)
      session[:user_id] = user.id
      flash[:info] = "Vous êtes maintenant connecté"
      redirect_to users_home_path
    end
end
