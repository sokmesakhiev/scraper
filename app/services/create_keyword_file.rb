class CreateKeywordFile < BaseService
  def call
    keyword_file = KeywordFile.new(user:, name: file.original_filename)
    keyword_file.original_file.attach(
      io: StringIO.open(file.read.force_encoding('UTF-8'), 'rb'),
      filename: file.original_filename,
      content_type: 'text/csv',
      identify: false
    )
    keyword_file.save!

    keyword_file
  end

  private

  def file
    attributes.fetch(:file)
  end

  def user
    attributes.fetch(:user)
  end
end
