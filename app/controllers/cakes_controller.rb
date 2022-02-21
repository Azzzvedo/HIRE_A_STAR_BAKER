class CakesController < ApplicationController
  before_action :set_current_user, only: %i[new create]
  before_action :set_cake, only: %i[show]


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
