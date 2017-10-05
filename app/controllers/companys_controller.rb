class CompanysController < ApplicationController

  def new
    @company = Company.new
  end

  def index
    if current_user.admin?
      @companies = Company.all
    else
      @companies = current_user.companies
    end
  end



  def create
    @company = Company.new(company_params)
    @companies = Company.all
    respond_to do |format|
      if @company.save
        flash.now[:success] = "Successfully created company"
        format.js {}
      else
        flash.now[:danger] = "Company not created"
        format.js {}
      end
    end
  end

  def show
    @company = Company.find(params[:id])
    @members=@company.users
    if current_user.admin?
      @tasks = @company.tasks
    else
      @tasks = @company.tasks.where(user_id: current_user.id)
    end
  end

  def remove_user
    @company = Company.find(params[:id])
    @members=@company.users
    respond_to do |format|
      @company.users.delete(params[:user_id])
      format.js {}
    end
  end

  def update
    @company = Company.find(params[:id])
    if @company.update_attributes(company_params)
      flash[:success] = "Profile updated"
      redirect_to @company_path

    else
      render 'edit'
    end
  end

  def destroy
    @company =  Company.find(params[:id])
    @companies = Company.all
    respond_to do |format|
      @company.destroy
      flash.now[:success] = "Company deleted Successfully!!"
      format.js {}
    end
  end

  def del_modal
    @company = Company.find(params[:id])
    respond_to do |format|
      format.js {}
    end
  end

  private

  def company_params
    params.require(:company).permit(:name,:maxcount,:avatar)
  end

end
