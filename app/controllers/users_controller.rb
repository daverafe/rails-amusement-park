class UsersController < ApplicationController

    def new
        @user = User.new 
    end

    def create
        if params[:admin] != nil 
            user = User.new(user_params)
            user.admin = true 
            if user.save 
                session[:user_id] = user.id
                redirect_to user_path(user)
            else
                render :new 
            end
        else
            user = User.new(user_params)
            if user.save 
                session[:user_id] = user.id 
                redirect_to user_path(user)
            else
                render :new 
            end
        end
    end

    def show
        if !logged_in?
            redirect_to root_path
        else
            @user = User.find_by_id(params[:id])
        end
    end

    private

    def user_params
        params.require(:user).permit(:name, :password, :happiness, :nausea, :height, :tickets, :admin)
    end

end
