class KeywordsController < ApplicationController
  def index
    @keywords = current_user.keywords.includes(:keyword_file).order(created_at: :desc)
    @keywords = @keywords.where("term like ?", "%#{params['query']}%") if params["query"].present?
  end

  def destroy
    current_user.keywords.find(params[:id]).destroy!

    if keyword_file.present?
      redirect_to keyword_file_keywords_path(keyword_file), notice: "Deleted!"
    else
      redirect_to keywords_path, notice: "Deleted!"
    end
  end

  private

  def keyword_file
    @keyword_file ||= current_user.keyword_files.find_by(id: params[:keyword_file_id])
  end
end
