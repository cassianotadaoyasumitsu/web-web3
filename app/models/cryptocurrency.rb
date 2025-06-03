class Cryptocurrency
    include ActiveModel::Model
  
    attr_accessor :id, :symbol, :name, :image, :current_price, :market_cap,
                  :market_cap_rank, :total_volume, :high_24h, :low_24h,
                  :price_change_24h, :price_change_percentage_24h,
                  :market_cap_change_24h, :market_cap_change_percentage_24h,
                  :circulating_supply, :total_supply, :max_supply, :ath,
                  :ath_change_percentage, :ath_date, :atl, :atl_change_percentage,
                  :atl_date, :last_updated
  
    def self.from_api_data(data)
      new(
        id: data['id'],
        symbol: data['symbol'],
        name: data['name'],
        image: data['image'],
        current_price: data['current_price'],
        market_cap: data['market_cap'],
        market_cap_rank: data['market_cap_rank'],
        total_volume: data['total_volume'],
        high_24h: data['high_24h'],
        low_24h: data['low_24h'],
        price_change_24h: data['price_change_24h'],
        price_change_percentage_24h: data['price_change_percentage_24h'],
        market_cap_change_24h: data['market_cap_change_24h'],
        market_cap_change_percentage_24h: data['market_cap_change_percentage_24h'],
        circulating_supply: data['circulating_supply'],
        total_supply: data['total_supply'],
        max_supply: data['max_supply'],
        ath: data['ath'],
        ath_change_percentage: data['ath_change_percentage'],
        ath_date: data['ath_date'],
        atl: data['atl'],
        atl_change_percentage: data['atl_change_percentage'],
        atl_date: data['atl_date'],
        last_updated: data['last_updated']
      )
    end
  end 