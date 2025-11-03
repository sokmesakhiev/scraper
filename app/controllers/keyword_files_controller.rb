class KeywordFilesController < ApplicationController
  def index
    @keyword_files = keyword_files
    @keyword_files = @keyword_files.where('name like ?', "%#{params['query']}%") if params['query'].present?
  end

  def new
    @keyword_file = KeywordFile.new
  end

  def create
    file = keyword_file_params[:file]

    keyword_file = CreateKeywordFile.call(file:, user: current_user)
    @keyword_files = current_user.keyword_files.order(created_at: :desc)

    if keyword_file.errors.empty?
      respond_to do |format|
        format.html { redirect_to keyword_files_path, notice: "Uploaded!" } # fallback
      end

    else
      render :new, error: "Keywords upload failed."
    end
  end

  def destroy
    current_user.keyword_files.find(params[:id]).destroy!

    redirect_to keyword_files_path, notice: "Deleted!"
  end

  private

  def keyword_file_params
    params.require(:keyword_file).permit(:file)
  end

  def keyword_files
    current_user.keyword_files.order(created_at: :desc)
  end
end
