class ApplicationController < ActionController::API

        def authorize_user!
            if !current_user.present?
            render json: {error: 'No user id present'}
            end
        end

        def current_user
            @current_user ||= User.find_by(id: user_id)
        end

        def user_id
            request.headers['Authorization']
        end

end