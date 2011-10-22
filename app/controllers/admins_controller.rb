class AdminsController < ApplicationController
  
  before_filter :require_login
  
 def new
  @admin = Admin.new
  end

  def create
    @admin = Admin.new(params[:admin])
    if @admin.save
      redirect_to log_in_url, :notice => "Signed up!"
    else
      render "new"
    end
  end
  
  def index
    if current_admin == nil
      redirect_to log_in_url, :notice => "Tem de fazer login!"
    else
      @shoppings = Shopping.all

      respond_to do |format|
        format.html # index.html.erb
        format.json { render :json => @shoppings }
      end
    end
  end

end
