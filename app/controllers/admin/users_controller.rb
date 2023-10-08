class Admin::UsersController < ApplicationController
  
  def index
    @customers = Customer.page(params[:page]).per(10)
  end

  def show
    @customer = Customer.find(params[:id])
    @status   = Customer.select("is_deleted").find_by(id: params[:id]) 
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    
    if @customer.update(customer_params)
      redirect_to admin_customer_path(@customer), notice: "会員情報を更新しました。"
    else
      flash.now[:danger] = "予期せぬエラーが発生しました"
      @status   = Customer.select("is_deleted").find_by(id: params[:id]) 
      render 'show'
    end
  end
  
  private
  
  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :email, :is_deleted)
  end
end
