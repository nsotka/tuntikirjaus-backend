class Api::V1::ProjectsController < ApplicationController
    before_action :find_project, only: [:show, :update, :destroy]
    before_action :authenticate_user!
    

    def index
        @projects = Project.all
        render json: @projects.to_json(include: :tasks)
    end

    def show
        render json: @project.to_json(:include => {:tasks => {:include => :user_tasks}})
        #render json: @project
    end

    def create
        @project = Project.new(project_params)
        if @project.save
            render json: @project
            ActionCable.server.broadcast 'projects_channel', action: "create", project: @project
            head :ok
        else
            render json: { error: 'Unable to create project.' }, status: 400
        end
    end

    def update
        if @project
            @project.update(project_params)
            ActionCable.server.broadcast 'projects_channel', action: "edit", project: @project
            head :ok
            #render json: { message: 'Project successfully updated.'}, status: 200
        else
            render json: { error: 'Unable to update project.'}, status: 400
        end
    end

    def destroy
        if @project && current_user.admin?
            @project.destroy
            ActionCable.server.broadcast 'projects_channel', action: "delete", project: @project
            head :ok
            #render json: { message: 'Project successfully deleted.'}, status: 200
        else
            render json: { error: 'Unable to delete project.'}, status: 400
        end
    end


    private

    def project_params
        params.require(:project).permit(:project_name, :start_time, :end_time)
    end

    def find_project
        @project = Project.find(params[:id])
    end
end
