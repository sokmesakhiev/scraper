module Scrapers
  module Bing
    class Scraper < Scrapers::BaseScraper
      def process
        parse_reponse client.scrap(term:)
      end

      private

      def client
        Scrapers::Bing::Client.new
      end

      def parse_reponse(html_response)
        doc = Nokogiri::HTML(html_response)

        {
          html_code: html_response.body,
          total_ads: estimate_ads(doc),
          total_link: doc.css('a').count
        }
      end

      def estimate_ads(doc)
        selectors = [
          # common ad container classes/attributes heuristics
          '[class*="ad"]',
          '[class*="Ad"]',
          '[id*="ad"]',
          '[data-ad]',
          '[aria-label*="ads"]',
          '[aria-label*="Ad"]',
          'div.b_ad'   # bing sometimes uses b_ad
        ]

        # Combine counts but avoid counting too loosely; filter by visible anchors inside those containers
        ad_containers = selectors.flat_map { |sel| doc.css(sel).to_a }.uniq

        # further filter: require that container contains "Ad" label or anchor pointing away
        ad_like = ad_containers.select do |node|
          text = node.text.to_s
          # contains typical ad signals
          (text =~ /\bAd(s)?\b/i) || node.css('a').any? { |a| a[:href].present? }
        end

        # Count distinct advertisers: we can count distinct domains from anchor hrefs inside ad_like containers
        domains = ad_like.flat_map do |node|
          node.css('a').map { |a| a[:href] }.compact
        end.map do |href|
          begin
            uri = URI.parse(href)
            uri.host&.downcase
          rescue
            nil
          end
        end.compact.uniq

        # If we didn't detect any ad containers, but there exist elements with "Sponsored" or "Ad" label:
        sponsored_labels = doc.xpath("//*[contains(translate(text(), 'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz'), 'sponsored') or contains(translate(text(), 'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz'), 'ad')]")
        if domains.empty? && sponsored_labels.any?
          # rough fallback: count sponsored elements
          return [sponsored_labels.count, 1].max
        end

        domains.count
      end
    end
  end
end
