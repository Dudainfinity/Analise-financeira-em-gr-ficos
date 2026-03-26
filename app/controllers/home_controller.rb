require 'net/http'
require 'json'

class HomeController < ApplicationController
CURRENCIES = [
    { code: "USD-BRL", name: "Dólar (USD/BRL)", color: "#2563eb" },
    { code: "EUR-BRL", name: "Euro (EUR/BRL)", color: "#16a34a" },
    { code: "BTC-BRL", name: "Bitcoin (BTC/BRL)", color: "#f59e0b" }
]

    def index
        @chart_data = []


        CURRENCIES.each do |currency|
            url = URI("https://economia.awesomeapi.com.br/json/daily/#{currency[:code]}/30")
            response = Net::HTTP.get(url)
            data = JSON.parse(response)

            hash = {}

            # A API pode retornar Hash de erro em vez de Array — ignorar nesses casos
            if data.is_a?(Array)
                data.each do |entry|
                    next unless entry.is_a?(Hash)
                    next if entry["timestamp"].nil? || entry["high"].nil?

                    date = Time.at(entry["timestamp"].to_i).strftime("%d/%m/%Y")
                    rate = entry["high"].to_f

                    hash[date] = rate
                end
            end

            @chart_data << {
                name: currency[:name],
                code: currency[:code],
                color: currency[:color],
                data: hash
            }
        end
    end
end
