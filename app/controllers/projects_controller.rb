class ProjectsController < ApplicationController

before_action :require_login, except: :index 
load_and_authorize_resource
def index
	@projects = Project.all
end

def new
	@project = Project.new
end

def create
	@project = Project.new(project_params)
	
	if @project.save

		redirect_to projects_url
		
	else
		render :new
	end
		
end

def show
	@project = Project.find(params[:id])
end

private

def project_params
	params.require(:project).permit(:name, :goal, :description, :end_date, rewards_attributes: [:id, :amount, :description, :_destroy])
	
end
end
