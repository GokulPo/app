class UsersController < ApplicationController

  def new
    @user =User.new
  end

  def index
    if current_user.admin?
      @companies= Company.all
    else
      @companies = current_user.companies
    end
  end

  def show
    @user = current_user
    #@user = User.finds(params[:id])
  end

  #adding a user to database
  def usercreate
    @user = User.new(user_params)
    @pwd = @user.password
    @company=Company.find(params[:user][:company_id])
    if @company.maxcount.to_i > @company.users.count
      respond_to do |format|
        if @user.save
            @company.users << @user
            @members=@company.users
            ExampleMailer.sample_email(@user,@pwd).deliver
            flash[:success] = "User created"
            format.js   { }
        else
          flash.now[:alert] = "User not created"
          render 'new'
        end
      end
    else
      respond_to do |format|
        format.js
      end
    end
  end


private

  def user_params
    params.require(:user).permit(:firstname,:lastname,:email,:password,:password_confirmation,:role_id,:dob,:phone)
  end

end
