class Api::UsersController < ApplicationController
  def index
    @users = User.all
    render 'index', formats: 'json', handlers: 'jbuilder'
  end

  def create
    @user = User.new
    if User.create(user_params)
      @users = User.all
      render json: {
          status: 'ok', users: @users
      }
    else
      render json: {
          status: 'ng'
      }
    end
  end

  def update
    @user = User.find(user_params[:id])

      if @user.update(user_params)
        @users = User.all
        render json: {
            status: 'ok', users: @users
        }
      else
        render json: {
            status: 'ng'
        }
      end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    @users = User.all
    render json: {
        status: 'ok', users: @users
    }
  end

  def exists
    if params[:id].present?

    else

    end
    render json: {
        valid: true
    }
  end

  def user_params
    json_params = ActionController::Parameters.new(JSON.parse(request.body.read))
    json_params.require(:user).permit(:id, :username, :email, :password)
  end
end