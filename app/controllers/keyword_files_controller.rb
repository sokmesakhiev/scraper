class KeywordFilesController < ApplicationController
  def new
    @keyword_file = KeywordFile.new
  end
end
