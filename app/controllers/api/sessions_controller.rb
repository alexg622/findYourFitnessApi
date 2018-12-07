class Api::SessionsController < ApplicationController
  def create
    @user = User.find_by_credentials(params[:user][:email], params[:user][:password])
    if @user
      sign_in(@user)
      @event_tickets = @user.event_tickets
      render "api/users/show"
    else
      render json: ["Invalid username/password combination"], status: 401
    end
  end

  def destroy
    @user = current_user
    @event_tickets = @user.event_tickets
    if @user
      sign_out
      render "api/users/show"
    else
      render json: ["Nobody signed in"], status: 404
    end
  end
end
