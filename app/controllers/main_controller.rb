class MainController < ApplicationController
  before_action :authenticate_user!
  def index
    logger.debug("main")
  end
end
