class CreateKeywordFileService < BaseService
  def call
    keyword_file = create_keyword_file
    create_keyword(keyword_file)

    ScrapingKeywordsJob.perform_later(keyword_file_id: keyword_file.id, terms:)

    keyword_file
  end

  private

  def create_keyword_file
    keyword_file = KeywordFile.new(user:, name: file.original_filename)
    keyword_file.original_file.attach(
      io: StringIO.open(content, "rb"),
      filename: file.original_filename,
      content_type: "text/csv",
      identify: false
    )
    keyword_file.save!

    keyword_file
  end

  def create_keyword(keyword_file)
    keyword_file.keywords.create!(terms.map { |term| { term:, status: "pending" } })
  end

  def file
    attributes.fetch(:file)
  end

  def user
    attributes.fetch(:user)
  end

  def content
    @content ||= file.read.force_encoding("UTF-8")
  end

  def terms
    @terms ||= content.split(",").map(&:strip)
  end
end
