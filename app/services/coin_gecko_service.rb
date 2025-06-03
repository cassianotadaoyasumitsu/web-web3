require 'httparty'

class CoinGeckoService
  include HTTParty

  BASE_URL = 'https://api.coingecko.com/api/v3'
  API_KEY = ENV['COINGECKO_API_KEY']

  class ApiKeyMissingError < StandardError; end
  class CoinNotFoundError < StandardError; end

  def self.fetch_market_data(page: 1, per_page: 100)
    validate_api_key!
    
    response = HTTParty.get(
      "#{BASE_URL}/coins/markets",
      query: {
        vs_currency: 'usd',
        x_cg_demo_api_key: API_KEY,
        page: page,
        per_page: per_page
      }
    )

    if response.success?
      {
        data: response.parsed_response,
        pagination: {
          current_page: page,
          total_pages: extract_total_pages(response),
          total_items: extract_total_items(response)
        }
      }
    else
      Rails.logger.error("CoinGecko API error: #{response.code} - #{response.body}")
      raise "Failed to fetch market data: #{response.code}"
    end
  rescue StandardError => e
    Rails.logger.error("Error fetching market data: #{e.message}")
    raise
  end

  def self.fetch_coin_data(coin_id)
    validate_api_key!
    
    response = HTTParty.get(
      "#{BASE_URL}/coins/markets",
      query: {
        vs_currency: 'usd',
        ids: coin_id,
        x_cg_demo_api_key: API_KEY
      }
    )

    if response.success?
      data = response.parsed_response.first
      if data.nil?
        raise CoinNotFoundError, "Coin '#{coin_id}' not found"
      end
      { data: data }
    else
      Rails.logger.error("CoinGecko API error: #{response.code} - #{response.body}")
      raise "Failed to fetch coin data: #{response.code}"
    end
  rescue StandardError => e
    Rails.logger.error("Error fetching coin data: #{e.message}")
    raise
  end

  private

  def self.validate_api_key!
    raise ApiKeyMissingError, "CoinGecko API key is not configured" if API_KEY.blank?
  end

  def self.extract_total_pages(response)
    # CoinGecko uses X-Total-Pages header for pagination
    response.headers['X-Total-Pages']&.to_i || 1
  end

  def self.extract_total_items(response)
    # CoinGecko uses X-Total-Count header for total items
    response.headers['X-Total-Count']&.to_i || 0
  end
end 