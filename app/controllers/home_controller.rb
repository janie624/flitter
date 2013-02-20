class HomeController < ApplicationController
	
	before_filter :authenticate_user!
	
	def index
		@flits = current_user.all_flits
		@last_flit = current_user.flits.last
	end

	def show
		@user = User.find_by_user_name(params[:username])
		@flits = @user.all_flits
	end

	def toggle_follow
		@user = User.find_by_user_name(params[:username])
		if current_user.is_friend? @user
			flash[:notice] = "You are no longer following #{@user.user_name}."
			current_user.remove_friend(@user)
		else
			flash[:notice] = "You are following #{@user.user_name} now."	
			current_user.add_friend(@user)
		end

		redirect_to user_flits_path(@user.user_name)
	end

	def toggle_follow_via_ajax
		user = User.find_by_user_name(params[:username])
		if current_user.is_friend? @user
			current_user.remove_friend(user)
		else
			current_user.add_friend(user)
		end

		render :text => "#{user.user_name}"
	end

	def following
		@friends = current_user.friends
	end

	def remove_friend
		friend = User.where("user_name = ?", params[:user_name]).first
		if friend
			current_user.remove_friend(friend)
			render :text => friend.user_name
		else
			render :text => "None"
		end
	end

	def search
		@users = User.find_by_search_query(@q)
	end
end
 