class UsersController < ApplicationController
  def index
  end

  def new
    @user = User.new
    @city = City.new
  end

  def create
    if City.find_by(name: params[:city_name])
      @city = City.find_by(name: params[:city_name])
    else
      @city = City.create(name: params[:city_name], zip_code: params[:city_zip_code])
    end

    @user = User.new(
    first_name: params[:first_name],
    last_name: params[:last_name],
    description: params[:description],
    email: params[:email],
    age: params[:age],
    city_id: @city.id,
    password: params[:password],
    password_confirmation: params[:password_confirmation]
    )

    if @user.save
      flash[:success] = "Welcome #{@user.first_name}!"
      log_in(@user)
      redirect_to index_path #Affiche l'index des gossips
    else
      render 'new' # Reste sur la view de gossips New.
    end   
  end
end
