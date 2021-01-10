class Api::V1::SessionsController < Devise::SessionsController
    before_action :sign_in_params, only: :create
    before_action :load_user, only: :create

    #sign_in
    def create
        if @user.valid_password?(sign_in_params[:password])
            sign_in("user", @user)
            render json: {
                message: "Signed In Successfully",
                is_success: true,
                #data: {user: @user}
                data: {user: { id: @user.id, isAdmin: @user.admin}}
            }, status: :ok
        else
            render json: {
                message: "Signed In Failed - Unauthorized",
                is_success: false,
                data: {}
            }, status: :ok
        end
    end

    private

    def sign_in_params
        params.require(:user).permit(:email, :password)
    end

    def load_user
        @user = User.find_for_database_authentication(email: sign_in_params[:email])
        if @user
            return @user
        else
            render json: {
                message: "Cannot get User",
                is_success: false,
                data: {}
            }, stataus: :failure
        end
    end
end
