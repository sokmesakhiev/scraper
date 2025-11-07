module Scrapers
  module Bing
    class Client
      BING_URL = "https://www.bing.com/search"
      TIME_OUT = 15

      def scrap(term:)
        url = generate_url(term)
        response = request(url)

        return response if response.success?

        puts "Failed to scrap data from Bing with status #{response.code}"

        []
      end

      private

      def request(url)
        HTTParty.get(url, headers: default_headers, timeout: TIME_OUT)
      end

      def generate_url(term)
        encoded_query = URI.encode_www_form(q: term)

        url = "#{BING_URL}?#{encoded_query}"
      end

      def default_headers
        {
          "User-Agent" => "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/121.0.0.0 Safari/537.36"
        }
      end
    end
  end
end
