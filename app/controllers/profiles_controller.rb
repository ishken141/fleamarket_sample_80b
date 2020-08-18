class ProfilesController < ApplicationController
  before_action :set_user_profile, only: [:edit, :update]
  # def new
  #   @user = User.find(params[:user_id])
  #   @profile = Profile.new
  # end

  # def create
  #   @user = User.find(params[:user_id])
  #   @profile = Profile.new(profile_params)
  #   if @profile.update(profile_params)
  #     redirect_to user_path(@user)
  #   else
  #     render :new
  #   end
  # end

  def edit
  end

  def update
    if @profile.update(profile_params)
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  private
  def set_user_profile
    @user = User.find(params[:user_id])
    @profile = Profile.find(params[:id])
  end

  def profile_params
    params.require(:profile).permit(:text, :image).merge(user_id: current_user.id)
  end
end
