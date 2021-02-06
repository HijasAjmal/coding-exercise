class ProductsController < ApplicationController
  
  # fetching currency rates just before executing specified actions
  before_action :currency_rates, :only => [:index, :show]

  def index
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
  end

  private

  def product_params
    params.require(:product).permit(:name, :description, :price_in_cents)
  end
  
  # fetch currency rates from application configuration file
  # config/currency_rate.yml
  # will return currency rates along with it's type
  def currency_rates
    @currency_rates = fetch_currency_rates
  end
end
