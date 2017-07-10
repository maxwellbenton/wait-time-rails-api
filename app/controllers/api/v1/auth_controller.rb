module Api
  module V1
    class AuthController < ApplicationController
        before_action :authorize_user!, only: [:show]

        def index
            render json: User.all
        end
        
        def show
            render json: current_user, include: :wait_times
        end

        def create
            user = User.find_by(username: params[:username])
            if user.present? && user.authenticate(params[:password]) 
                render json: user, include: :wait_times
            else
                render json: {error: "Wrong username or password"}, status: 404
            end
        end 
        


      
    end
  end
end