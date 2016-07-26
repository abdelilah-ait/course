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
  	# if !@current_user.try(:admin?)
   #    flash[:error] = "Accès interdit"
   #  else
    	@users = User.all
    # end
  end

  def show
    @user = User.find_by(id: params[:id])
  end

  def new

      @user = User.new
      %w(home office mobile).each do |phone|
        @user.phones.build(phone_type: phone)
      end
  end

  def edit
    @user = User.find_by(id: params[:id])
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
    @newuser = User.new name: params[:name],  email: params[:email], password: params[:password], password_confirmation: params[:password_confirmation]
    if params[:password] == params[:password_confirmation]

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

  def update
    @user = User.find_by(id: params[:id])

    if @user.update(user_params)
      redirect_to users_show_path(@user)
    else
      flash[:info] = "your infos does not updated"
      render "edit"
    end
  end

  def delete 
    user = User.find_by(id: params[:id])
    user.destroy   
    redirect_to users_index_path
  end

  private

    def connect(user)
      session[:user_id] = user.id
      flash[:info] = "Vous êtes maintenant connecté"
      redirect_to users_home_path
    end
    def user_params
      params.permit(:name, :password, :password_confirmation, :email)
    end  
end
