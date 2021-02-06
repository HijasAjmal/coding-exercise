require 'rails_helper'

RSpec.describe CurrenciesController, type: :controller do
  describe "GET /fetch_currency_rate" do
    it "fetch currency rate of products set limit as (5) and returns a 200" do
      products = Product.limit(5)
      products.each do |product|
        get :fetch_currency_rate, :params => {:product_id => product.id, :currency => "EUR"}
        expect(response).to have_http_status(:ok)
      end
    end
  end
end
