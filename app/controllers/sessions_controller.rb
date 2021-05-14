class SessionsController < ApplicationController
  before_action :authenticate_user, only: [:index]

  def new
	end

	def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      log_in user
      redirect_to "/welcome/:first_name"
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

	def destroy
		session.delete(:user_id)
		redirect_to index_path
	end

  private

  def authenticate_user
    unless current_user
      flash[:danger] = "Please log in."
      redirect_to new_session_path
    end
  end
end
