class HomeController < ApplicationController
  def index
    @keyword_files = current_user.keyword_files
  end
end
