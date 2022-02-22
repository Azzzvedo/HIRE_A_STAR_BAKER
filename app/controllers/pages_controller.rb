class PagesController < ApplicationController
  def home
    @bakers = User.where(baker: true)
  end
end
