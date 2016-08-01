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
    @phones = ["Home", "Mobile", "Office"]
    @newphone = Phone.new
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
    @phone = Phone.find_by(id: params[:id])
    #  # render json: {user_name: @user.name, email: @user.email }
    #  respond_to do |format|
    #       format.html # index.html.erb
    #       format.json {render json:  @user.as_jason}
    # # # render :nothing => true, :status => 404
    #   end
  end

  def new

      @user = User.new
      %w(home office mobile).each do |phone|
        @user.phones.build(phone_type: phone)
      end
  end

  def edit
    @user = User.find_by(id: params[:id])
    @phones = ["Home", "Mobile", "Office"]
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
    @newuser = User.new name: params[:name], email: params[:email], password: params[:password], password_confirmation: params[:password_confirmation]
   
    newphone1 = Phone.new phone_type: params[:phone_type1], number: params[:number1]
    newphone2 = Phone.new phone_type: params[:phone_type2], number: params[:number2]
    newphone3 = Phone.new phone_type: params[:phone_type3], number: params[:number3]

    @newuser.phones = [newphone1, newphone2, newphone3]

    # phones = []
    # params[:phones].each do |phone|
    #   phones << Phone.new phone_type: params[:phone_type], number: params[:number]
    # end
    if params[:password] == params[:password_confirmation]

      if @newuser.save
        connect(@newuser)
      else
        redirect_to users_registre_path
      end
    else
      flash[:info] = "password confirmation invalid"
      redirect_to users_registre_path
    end
  end

  def update
    @user = User.find_by(id: params[:id])
    
    if @user.update(user_params)

      @user.phones[0].update(phone_type: params[:phone_type1], number: params[:number1]) if params[:number1].present?
      @user.phones[1].update(phone_type: params[:phone_type2], number: params[:number2]) if params[:number2].present?
      @user.phones[2].update(phone_type: params[:phone_type3], number: params[:number3]) if params[:number3].present?

      redirect_to users_show_path(@user)
    else
      flash[:info] = "your infos does not updated"
      redirect_to users_edit_path
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
