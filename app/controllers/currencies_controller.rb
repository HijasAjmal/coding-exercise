class CurrenciesController < ApplicationController
  
  # fetch currency rate of a product for a specified currency type
  # will respond back with currency details (currency type, currency rate)
  def fetch_currency_rate
    product = Product.find_by_id(params[:product_id])
    product_price = product.fetch_currency_rate(params[:currency])
    render json: {:status => true, :currency => product_price}
  end
end
