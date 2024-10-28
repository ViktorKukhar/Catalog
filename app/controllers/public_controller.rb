class PublicController < ApplicationController
  def index
    @records = Record.all
    @tags = Tag.all
    @users = User.all
  end
end
