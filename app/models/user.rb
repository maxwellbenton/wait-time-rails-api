class User < ApplicationRecord
    has_secure_password
    has_many :wait_times
    has_many :store_comments
    has_many :comments, through: :store_comments

    def index
        @users = User.all
        render json: @users
    end

    # def all_wait_times
    #     @wait_times = WaitTime.where(user_id: self.id)
    # end
    
end
