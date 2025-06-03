class CryptocurrenciesController < ApplicationController
  def index
    page = params[:page]&.to_i || 1
    per_page = params[:per_page]&.to_i || 100

    result = CoinGeckoService.fetch_market_data(page: page, per_page: per_page)
    @cryptocurrencies = result[:data].map { |data| Cryptocurrency.from_api_data(data) }
    @pagination = result[:pagination]
    
    render :index
  rescue CoinGeckoService::ApiKeyMissingError => e
    Rails.logger.error("API key error in CryptocurrenciesController#index: #{e.message}")
    flash.now[:error] = "Please configure the CoinGecko API key in your environment variables"
    @cryptocurrencies = []
    @pagination = { current_page: 1, total_pages: 1, total_items: 0 }
    render :index
  rescue StandardError => e
    Rails.logger.error("Error in CryptocurrenciesController#index: #{e.message}")
    flash.now[:error] = "Failed to load cryptocurrencies: #{e.message}"
    @cryptocurrencies = []
    @pagination = { current_page: 1, total_pages: 1, total_items: 0 }
    render :index
  end

  def show
    result = CoinGeckoService.fetch_coin_data(params[:id])
    @cryptocurrency = Cryptocurrency.from_api_data(result[:data])
    render :show
  rescue CoinGeckoService::ApiKeyMissingError => e
    Rails.logger.error("API key error in CryptocurrenciesController#show: #{e.message}")
    flash[:error] = "Please configure the CoinGecko API key in your environment variables"
    redirect_to cryptocurrencies_path
  rescue CoinGeckoService::CoinNotFoundError => e
    flash[:error] = "Cryptocurrency not found"
    redirect_to cryptocurrencies_path
  rescue StandardError => e
    Rails.logger.error("Error in CryptocurrenciesController#show: #{e.message}")
    flash[:error] = "Failed to load cryptocurrency: #{e.message}"
    redirect_to cryptocurrencies_path
  end
end 