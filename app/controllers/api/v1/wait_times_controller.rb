class Api::V1::WaitTimesController < ApplicationController
    
    def index
        @times = WaitTime.all
        render json: @times
    end

    def create
        time = WaitTime.create(wait_time_params)
        puts time.created_at
        render json: time
    end

    # def add_comment
    #     time = WaitTime.find(comment: params[:wait_time][:id]) #find wait time
    #     feedback = Comment.find(feedback: params[:feedback]) #find existing comment
    #     comment = StoreComment.create(user: time.user store: time.store feedback: feedback) #create comment
    #     render json: comment
    # end
    
  
    

    private

    def wait_time_params
        params.require(:wait_time).permit(:wait_time, :store_id, :user_id)
    end

    
end
