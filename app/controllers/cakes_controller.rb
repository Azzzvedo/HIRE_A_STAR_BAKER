class CakesController < ApplicationController
  before_action :set_current_user, only: %i[new create destroy]
  before_action :set_cake, only: %i[show destroy]

  def show; end

  def new
    @cake = Cake.new
  end

  def create
    @cake = Cake.new(cake_params)
    @cake.user = @user
    @cake.save
    redirect_to cake_path(@cake)
  end

  def destroy
    @cake.destroy
    link_to user_show(@user)
  end

  private

  def set_cake
    @cake = Cake.find(params[:id])
  end

  def set_current_user
    @user = current_user
  end

  def cake_params
    params.require(:cake).permit(:name, :price)
  end
end
