class UsersController < ApplicationController
    def index
        users = User.all
        render json: users
      end

    def create
        user=User.create(user_params)
        if user.valid?
        session[:user_id]=user.id
        render json:user
        else
            render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
        end
    end
            
    def show
        if session[:user_id]
        render json: User.find(session[:user_id])
        else
        render json: { error: "Access restricted" }, status: :unauthorized
        end
        
        
    end
        
    private 
        
    def user_params
        params.permit(:username, :password, :password_confirmation)
    end
end
