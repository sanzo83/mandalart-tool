class WelcomeController < ApplicationController
  def index
    if user_signed_in?
      redirect_to '/main/index'
    end
  end
end
