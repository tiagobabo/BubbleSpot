class AdminsController < ApplicationController
 def new
  @admin = Admin.new
  end

  def create
    @admin = Admin.new(params[:admin])
    if @admin.save
      redirect_to root_url, :notice => "Signed up!"
    else
      render "new"
    end
  end

end
