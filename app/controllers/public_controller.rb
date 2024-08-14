class PublicController < ApplicationController
  def index
    @records = Record.all
    @tags = Tag.all
  end

end
