class CreateKeywordFileService < BaseService
  def call
    keyword_file = create_keyword_file
    create_keyword(keyword_file)

    ScrapingKeywordsJob.perform_later(keyword_file_id: keyword_file.id, terms:)

    keyword_file
  end

  private

  def create_keyword_file
    keyword_file = KeywordFile.new(user:, name: filename)
    keyword_file.original_file.attach(
      io: StringIO.open(csv_content, "rb"),
      filename:,
      content_type: "text/csv",
      identify: false
    )
    keyword_file.save!

    keyword_file
  end

  def create_keyword(keyword_file)
    keyword_file.keywords.create!(terms.map { |term| { term:, status: "pending" } })
  end

  def csv_content
    attributes.fetch(:csv_content)
  end

  def user
    attributes.fetch(:user)
  end

  def terms
    @terms ||= csv_content.split(",").map(&:strip)
  end

  def filename
    @filename ||= attributes.fetch(:filename)
  end
end
