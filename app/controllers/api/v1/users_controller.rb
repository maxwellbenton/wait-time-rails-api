class Api::V1::UsersController < ApplicationController
    
    def show
        @user = User.find(params[:_json])
        render json: @user, include: :wait_times
    end
    
    def create
        
        @user = User.find_by(username: params[:user][:username])
        if @user == nil then
            @user = User.create(username: params[:user][:username], password: params[:user][:password])
        end
        byebug
        render json: @user, include: :wait_times
    end
    
    
end
