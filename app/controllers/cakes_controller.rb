class CakesController < ApplicationController
  before_action :set_current_user, only: %i[new create destroy]
  before_action :set_cake, only: %i[show edit update destroy]

  def index
    @cakes = Cake.all
  end

  def show; end

  def new
    @cake = Cake.new
  end

  def create
    @cake = Cake.new(cake_params)
    @cake.user = @user
    @cake.save
    redirect_to user_show_path(@user)
  end

  def edit; end

  def update
    @cake.update(cake_params)
    redirect_to cake_path(@cake)
  end

  def destroy
    @cake.destroy
    redirect_to user_show_path(@user)
  end

  private

  def set_cake
    @cake = Cake.find(params[:id])
  end

  def set_current_user
    @user = current_user
  end

  def cake_params
    params.require(:cake).permit(:name, :price, :photo)
  end
end
