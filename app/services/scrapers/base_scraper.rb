module Scrapers
  class BaseScraper
    def initialize(term:)
      @term = term
    end

    attr_reader :term
  end
end
