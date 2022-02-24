class PagesController < ApplicationController
  def home
    @bakers = User.where(baker: true)
  end

  def user_show
    @user = User.find(params[:user_id])
  end

end
