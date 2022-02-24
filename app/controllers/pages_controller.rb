class PagesController < ApplicationController
  def home
    @bakers = User.joins(:cakes).where(baker: true).where.not('cakes.user_id is null').uniq.shuffle
  end

  def user_show
    @user = User.find(params[:user_id])
  end
end
