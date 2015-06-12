class RegistrationsController < ApplicationController

  def index
    # @registrations = Registration.all
    @project = Project.find(params[:project_id])
    @registrations = @project.registrations  
  end

  def new
    @project = Project.find(params[:project_id])
    @registration = @project.registrations.new
  end

  def create
    @project = Project.find(params[:project_id])
    @registration = @project.registrations.new(registration_params)
    if @registration.save
      redirect_to project_registrations_path(@project),
                   notice: "Thanks, you're registered!"
    else
      render :new
    end
  end

private

  def registration_params
    params.require(:registration).permit(:name, :email, :how_heard)
  end
end

