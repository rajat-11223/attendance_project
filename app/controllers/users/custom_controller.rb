class Users::CustomController < ApplicationController
	before_action :set_User, only: [ :edit, :update, :destroy]
	before_action :authenticate_user!, except: [:index, :show]


	# Action to show Admin and User Dashboard
	def dashboard
		@users = User.all.where.not(id: current_user.id)
	end




	private
    # Use callbacks to share common setup or constraints between actions.
	    def set_review
	      @user = User.find(current_user.id)
	    end
end