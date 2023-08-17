class UserSessionsController < ApplicationController
  def new;end

  def create   
    @user = login(params[:email], params[:password])
    if @user
      redirect_back_or_to tourist_spots_path, success: t('.success')
    else
        flash.now[:danger] = t('.fail')
        render :new, status: :unprocessable_entity
    end
  end
  
  def destroy
    logout
    redirect_to root_path, status: :see_other, success: t('.success')
  end
end
