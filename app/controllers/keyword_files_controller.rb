class KeywordFilesController < ApplicationController
  def index
    @keyword_files = keyword_files
    @keyword_files = @keyword_files.where("name like ?", "%#{params['query']}%") if params["query"].present?
  end

  def create
    file = keyword_file_params[:file]

    unless file.content_type.in?(%w[text/csv application/csv])
      return render_upload_error("Invalid file type. Please upload a CSV file.")
    end

    if total_terms < 1 || total_terms > 100
      return render_upload_error("Invalid file size. Please upload a file with 1-100 terms.")
    end

    keyword_file = CreateKeywordFileService.call(filename:, csv_content:, user: current_user)
    @keyword_files = current_user.keyword_files.order(created_at: :desc)

    if keyword_file.errors.empty?
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to keyword_files_path, notice: "Uploaded!" }
      end
    else
      render :new, error: "Keywords upload failed."
    end
  end

  def download
    keyword_file = current_user.keyword_files.find(params[:keyword_file_id])
    csv_data = keyword_file.original_file.download

    send_data csv_data, filename: keyword_file.name, type: "text/csv", disposition: "attachment"
  end

  def destroy
    current_user.keyword_files.find(params[:id]).destroy!

    redirect_to keyword_files_path, notice: "Deleted!"
  end

  def show
    @keyword_file = current_user.keyword_files.find(params[:id])
    @keywords = @keyword_file.keywords.includes(:keyword_file).order(created_at: :desc)
    @keywords = @keywords.where("term like ?", "%#{params['query']}%") if params["query"].present?
  end

  private

  def keyword_file_params
    params.require(:keyword_file).permit(:file)
  end

  def keyword_files
    current_user.keyword_files.order(created_at: :desc)
  end

  def csv_content
    @csv_content ||= keyword_file_params[:file].read
  end

  def filename
    @filename ||= keyword_file_params[:file].original_filename
  end

  def total_terms
    @total_terms ||= csv_content.split(",").size
  end

  def render_upload_error(message)
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace(
          "upload_errors",
          partial: "keyword_files/upload_errors",
          locals: { errors: [ message ] }
        )
      end
      format.html { redirect_to keyword_files_path, alert: message }
    end
  end
end
