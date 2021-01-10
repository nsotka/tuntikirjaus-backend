class Api::V1::UserTasksController < ApplicationController
    before_action :find_user_task, only: [:show, :update, :destroy]
    before_action :authenticate_user!

    def index
        render json: @tasks #.to_json(include: [:user_tasks])
    end

    def show
        render json: @user_task
    end

    def create
        @user_task = UserTask.new(user_task_params)
        if @user_task.save
            render json: @user_task
            ActionCable.server.broadcast 'tasks_channel', action: "create", user_task: @user_task
            head :ok
        else
            render json: { error: 'Unable to create user task.' }, status: 400
        end
    end

    def update
        if @user_task
            @user_task.update(user_task_params)
            ActionCable.server.broadcast 'tasks_channel', action: "edit", user_task: @user_task
            head :ok
            #render json: { message: 'User task successfully updated.'}, status: 200
        else
            render json: { error: 'Unable to update user task.'}, status: 400
        end
    end

    def destroy
        if @user_task
            @user_task.destroy
            render json: { message: 'User task successfully deleted.'}, status: 200
        else
            render json: { error: 'Unable to delete user task.'}, status: 400
        end
    end


    private

    def user_task_params
        params.require(:user_task).permit(:user_id, :task_id, :working_time)
    end

    def find_user_task
        @user_task = UserTask.where("user_id = ? AND task_id = ?", params[:user_id], params[:task_id])
    end
end
