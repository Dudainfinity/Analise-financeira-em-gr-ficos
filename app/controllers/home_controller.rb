require 'net/http'
require 'json'

class HomeController < ApplicationController
    CURRENCIES = [
        { code: "USD-BRL", name: "Dólar (USD/BRL)", color: "#2563eb" },
        { code: "EUR-BRL", name: "Euro (EUR/BRL)", color: "#16a34a" },
        { code: "BTC-BRL", name: "Bitcoin (BTC/BRL)", color: "#f59e0b" }
    ].freeze

    FALLBACK_DATA = {
        "USD-BRL" => {
            "19/03/2026" => 5.3244,
            "20/03/2026" => 5.3235,
            "22/03/2026" => 5.312,
            "23/03/2026" => 5.3659,
            "24/03/2026" => 5.292,
            "25/03/2026" => 5.26,
            "26/03/2026" => 5.2567
        },
        "EUR-BRL" => {
            "20/03/2026" => 6.15006,
            "21/03/2026" => 6.0619,
            "22/03/2026" => 6.035,
            "23/03/2026" => 6.21118,
            "24/03/2026" => 6.13121,
            "25/03/2026" => 6.10501,
            "26/03/2026" => 6.07165
        },
        "BTC-BRL" => {
            "20/03/2026" => 376451.0,
            "21/03/2026" => 377568.0,
            "22/03/2026" => 369926.0,
            "23/03/2026" => 379404.0,
            "24/03/2026" => 374923.0,
            "25/03/2026" => 376472.0,
            "26/03/2026" => 374294.0
        }
    }.freeze

    def index
        @chart_data = []


        CURRENCIES.each do |currency|
            hash = Rails.cache.fetch("currency-history:#{currency[:code]}", expires_in: 30.minutes) do
                fetch_currency_data(currency[:code])
            end

            @chart_data << {
                name: currency[:name],
                code: currency[:code],
                color: currency[:color],
                data: hash
            }
    end
    end

    private

    def fetch_currency_data(code)
        uri = URI("https://economia.awesomeapi.com.br/json/daily/#{code}/30")
        response = Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
            http.get(uri.request_uri, {
                "User-Agent" => "Mozilla/5.0",
                "Accept" => "application/json"
            })
        end

        data = JSON.parse(response.body)
        parsed = {}

        if data.is_a?(Array)
            data.reverse_each do |entry|
                next unless entry.is_a?(Hash)
                next if entry["timestamp"].nil? || entry["high"].nil?

                date = Time.at(entry["timestamp"].to_i).strftime("%d/%m/%Y")
                parsed[date] = entry["high"].to_f
            end
        end

        parsed.presence || FALLBACK_DATA.fetch(code, {})
    rescue StandardError
        FALLBACK_DATA.fetch(code, {})
    end
end
