class Api::V1::StoreCommentsController < ApplicationController

    def create
        
        time = WaitTime.create(store_id: params[:comment][:store_id], user_id: params[:comment][:user_id], wait_time: params[:comment][:wait_time])
        comment = Comment.find_by(feedback: params[:comment][:feedback])
        feedback = StoreComment.create(store_id: time.store.id, user_id: time.user.id, comment_id: comment.id, wait_time_id: time.id)

        render json: feedback
    end
    
    private

    def wait_time_params
        params.require(:wait_time).permit(:wait_time, :store_id, :user_id)
    end
    
end


