class Api::SessionsController < ApplicationController
  def create
    # Find user by credentials
    @user = User.find_by_credentials(params[:user][:username], params[:user][:password])
    # debugger
    if @user.nil?
      render json: ['Invalid credentials!'], status: 401
    else
      sign_in(@user)
      render 'api/users/show'
    end
  end

  def destroy
    if current_user.nil?
      render json: ['You can\'t log out'], status: 404
    else
      sign_out
      render json: {}
    end
  end
end
