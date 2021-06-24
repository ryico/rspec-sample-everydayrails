class TasksController < ApplicationController
  before_action :set_project
  before_action :project_owner?
  before_action :set_task, only: [:show, :edit, :update, :destroy, :toggle]

  def index
    @tasks = Task.all
  end

  def show
  end

  def new
    @task = @project.tasks.new
  end

  def edit
  end

  def create
    @task = @project.tasks.new(task_params)

    respond_to do |format|
      if @task.save
        format.html { redirect_to @project, notice: 'Task was successfully created.' }
        format.json { render :show, status: :created, location: [@task.project, @task] }
      else
        format.html { render :new }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      format.html { redirect_to @project, notice: 'Task was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def toggle
    @task.update_attributes(completed: !@task.completed)
  end

  private

    def set_task
      @task = Task.find(params[:id])
    end

    def task_params
      params.require(:task).permit(:name, :project_id, :completed)
    end
end