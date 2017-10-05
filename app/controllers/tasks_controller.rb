class TasksController < ApplicationController

  def new
    @task = Task.new
  end

  def index
    @tasks = Task.all
  end

  def create
    @task = Task.new(task_params)

    day = params[:task][:day]
    hour = params[:task][:hour]
    minute = params[:task][:minute]
    @task.expiry = Time.now + day.to_i.days + hour.to_i.hours + minute.to_i.minutes

    @company=Company.find(params[:task][:company_id])
    if @task.save!
      @company.tasks << @task
      flash[:success] = "Team Created"
      redirect_to companys_path
    else
      flash[:alert] = "Task not created."
      redirect_to companys_path
    end

  end

  def show
    @company = Company.find(params[:id])
  end

  def destroy
    @company = Company.find(params[:company_id])
    @task = Task.find(params[:id])
    @task.destroy
    redirect_to companys_path
  end

  def complete_task
    @task = Task.find(params[:id])
    @company = Company.find(params[:company_id])
    @task.update(status: true)
    @tasks = @company.tasks.where(user_id: current_user.id)
    respond_to do |format|
      format.js {}
    end
  end

  def incomplete_task
    @task = Task.find(params[:id])
    @company = Company.find(params[:company_id])
    @task.update(status: false)
    @tasks = @company.tasks.where(user_id: current_user.id)
    respond_to do |format|
      format.js {}
    end
  end

  private

  def task_params
    params.require(:task).permit(:name, :status, :user_id, :expiry)
  end
end
