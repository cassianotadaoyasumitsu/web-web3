# Web Web3 - Cryptocurrency Tracking Application

A modern web application built with Ruby on Rails that provides real-time cryptocurrency market data using the CoinGecko API.

## Features

- View real-time cryptocurrency market data
- Detailed information about individual cryptocurrencies
- Paginated results for better performance
- Modern UI with Tailwind CSS
- Responsive design for all devices

## Prerequisites

* Ruby version: 3.0.0 or higher
* Rails version: 8.0.2
* SQLite3 database
* CoinGecko API key

## System Dependencies

* Node.js and Yarn for asset compilation
* SQLite3 development libraries

## Configuration

1. Clone the repository
2. Install dependencies:
   ```bash
   bundle install
   ```
3. Set up your environment variables:
   ```bash
   cp .env.example .env
   ```
4. Add your CoinGecko API key to the `.env` file:
   ```
   COINGECKO_API_KEY=your_api_key_here
   ```

## Database Setup

```bash
rails db:create
rails db:migrate
```

## Running the Application

1. Start the Rails server:
   ```bash
   rails server
   ```
2. Visit `http://localhost:3000` in your browser

## Testing

Run the test suite with:
```bash
rails test
```

## API Integration

This application integrates with the CoinGecko API to fetch:
- Market data for cryptocurrencies
- Detailed information about specific cryptocurrencies
- Real-time price updates

## Deployment

The application is configured for deployment using Kamal. See the Kamal documentation for deployment instructions.

## Contributing

1. Fork the repository
2. Create your feature branch
3. Commit your changes
4. Push to the branch
5. Create a new Pull Request
