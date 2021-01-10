class Api::V1::TasksController < ApplicationController
    before_action :find_task, only: [:show, :update, :destroy]
    before_action :authenticate_user!

    def show
        render json: @task
    end

    def create
        @task = Task.new(task_params)
        if @task.save
            render json: @task
            ActionCable.server.broadcast 'tasks_channel', action: "create", task: @task
            head :ok
        else
            render json: { error: 'Unable to create task.' }, status: 400
        end
    end

    def update
        if @task
            @task.update(task_params)
            ActionCable.server.broadcast 'tasks_channel', action: "edit", task: @task
            head :ok
            #render json: { message: 'Task successfully updated.'}, status: 200
        else
            render json: { error: 'Unable to update task.'}, status: 400
        end
    end

    def destroy
        if @task && current_user.admin?
            @task.destroy
            ActionCable.server.broadcast 'tasks_channel', action: "delete", task: @task
            head :ok
            #render json: { message: 'Task successfully deleted.'}, status: 200
        else
            render json: { error: 'Unable to delete task.'}, status: 400
        end
    end


    private

    def task_params
        params.require(:task).permit(:task_name, :start_time, :end_time, :project_id, :task_category_id)
    end

    def find_task
        @task = Task.find(params[:id])
    end
end
