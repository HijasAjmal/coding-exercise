class Product < ApplicationRecord

  def price
    price_in_cents / 100.0
  end
  
  # fetch currency rate of product for specified currency type
  def fetch_currency_rate(currency_type)
    if currency_type == "EUR"
      product_price_details
    else
      fetch_updated_currency_rate(currency_type)
    end
  end
  
  # fetch currency details (currency type, currency rate)
  # this will return default currency type as "EUR" if the specified currency is not available
  def fetch_updated_currency_rate(currency_type)
    currency_rate = {}
    currency_details = {}
    begin
      ApplicationController.new.fetch_currency_rates.select{ |currency| currency_rate = currency if currency[:currency] == currency_type }
      actual_price = price.to_f * currency_rate[:rate].to_f
      currency_details = {:currency => currency_type, :price => actual_price.round(2)}
    rescue
      currency_details = product_price_details
    end
    currency_details
  end
  
  # fetch default currency details of product
  def product_price_details
    {:currency => 'EUR', :price => price}
  end
end
