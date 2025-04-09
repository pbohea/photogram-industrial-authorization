class UsersController < ApplicationController
  before_action :set_user, only: %i[ show liked feed discover ]
  before_action :is_an_authorized_user, only: [:feed, :discover]

  def index
    @users = @q.result
  end

  private

    def set_user
      if params[:username]
        @user = User.find_by!(username: params.fetch(:username))
      else
        @user = current_user
      end
    end

    def is_an_authorized_user
      if current_user != @user
        redirect_back fallback_location: root_url, alert: "You're not authorized for that."
      end
    end
end
