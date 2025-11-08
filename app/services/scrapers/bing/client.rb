module Scrapers
  module Bing
    class Client
      BING_URL = "https://www.bing.com/search"
      TIME_OUT = 15
      MAX_RETRY = 3
      WAIT_TIME = 1

      def scrap(term:)
        url = generate_url(term)
        response = request(url)

        return response if response.success?

        puts "Failed to scrap data from Bing with status #{response.code}"

        []
      end

      private

      def request(url)
        retried = 0

        begin
          Rails.logger.error("Connecting to Bing for scraping data with url: #{url}")
          HTTParty.get(url, headers: default_headers, timeout: TIME_OUT)
        rescue StandardError => e
          retried += 1
          if retried < MAX_RETRY
            sleep(WAIT_TIME * retried)

            retry
          else
            Rails.logger.error("Connecting to Bing failed after #{MAX_RETRY} attempts: #{e.message} with the url: #{url}")

            nil
          end
        end
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
