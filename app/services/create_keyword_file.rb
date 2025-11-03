class CreateKeywordFile < BaseService
  def call
    KeywordFile.create!(user:, name: file.original_filename, original_file: file)
  end

  private

  def file
    attributes.fetch(:file)
  end

  def user
    attributes.fetch(:user)
  end
end
