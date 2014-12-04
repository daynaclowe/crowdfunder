class PledgesController < ApplicationController
	before_filter :load_project

	def new
		@pledge = Pledge.new(amount: params[:amount])
		@reward = @project.match_reward(@pledge.amount)
	end

	def create
		@reward = @project.select_reward_tier(pledge_params[:amount])
		@pledge = @project.pledges.build(pledge_params)
		@pledge.reward_id = @reward.id
		@pledge.backer_id = current_user.id
		
		if @pledge.save

			redirect_to projects_path, notice: 'Pledge Succesful!'
			
		else
			render :new
		end
	end
	def show
		@pledge = Pledge.find(params[:id])
	end

	def load_project
		@project = Project.find(params[:project_id])	
	end


private
	def pledge_params
		params.require(:pledge).permit(:amount)
	end

end
