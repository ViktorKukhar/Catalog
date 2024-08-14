class UsersController < ApplicationController
  def profile
    @user = User.find(params[:id])
    @record = Record.all
  end

end
