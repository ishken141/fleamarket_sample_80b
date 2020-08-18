class UsersController < ApplicationController
  def new
    @user = User.new
  end
  
  def show
    @user = User.find(params[:id])
    @name = @user.name
    @items = @user.items
    # @profile = Profile.new
    @profile = Profile.find_by(user_id: current_user.id)
    @created_at = @user.created_at   
    # @zipcode = user.zipcode
    @address = @user.address 
    # @city = user.city
    # @street = user.street
    # @card = Credit.where(user_id: current_user.id)
  end
  
  def likes 
  end 

end
