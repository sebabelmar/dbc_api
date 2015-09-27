class V1::UsersController < ApplicationController
  skip_before_action :authenticate_user_from_token!, only: [:create]

  # POST /v1/users
  # Creates an user
  def create

p user_params
puts "*"*50
    if user_params['is_host']
      @user = User.new user_params
    else
      @user = User.new user_params
      host = User.find_by(host_code: user_params['host_code']
      @user.host = host.id
      host.guest = @user.id
      host.save
    end

    if @user.save
      render json: @user, serializer: V1::SessionSerializer, root: nil
    else
      render json: { error: t('user_create_error') }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :username, :is_host, :host_code,:password, :password_confirmation)
  end
end
