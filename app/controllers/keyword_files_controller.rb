class KeywordFilesController < ApplicationController
  def index
    @keyword_files = current_user.keyword_files
    @keyword_files = @keyword_files.where('name like ?', "%#{params['q']}%") if params['q'].present?
  end

  def new
    @keyword_file = KeywordFile.new
  end

  def create
    file = keyword_file_params[:file]

    create_keyword_file = CreateKeywordFile.call(file:)

    redirect_to root_path, notice: "Keywords uploaded! Processing started."
  end

  private

  def keyword_file_params
    params.require(:keyword_file).permit(:file)
  end
end
