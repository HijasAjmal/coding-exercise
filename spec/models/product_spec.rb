require 'rails_helper'

RSpec.describe Product, type: :model do
  describe '#price' do
    it 'returns a float' do
      expect(Product.new(price_in_cents: 1234).price).to eq(12.34)
    end
  end

  describe 'currency rate success case' do
    it 'returns a hash' do
      product_currency_rate = Product.new(price_in_cents: 1234).fetch_currency_rate("USD")
      expect(product_currency_rate[:currency]).to eq("USD")
    end
  end

  describe 'currency rate failure case' do
    it 'returns a hash' do
      product_currency_rate = Product.new(price_in_cents: 1234).fetch_currency_rate("NOCURRENCY")
      expect(product_currency_rate[:currency]).to eq("EUR")
    end
  end

  describe 'product default currency details' do
    it 'returns a hash' do
      product_price_details = Product.first.product_price_details
      expect(product_price_details.class).to eq(Hash)
    end
  end

  describe 'currency details of a product' do
    it 'returns a hash' do
      product_price_details = Product.first.fetch_updated_currency_rate("USD")
      expect(product_price_details.class).to eq(Hash)
    end
  end
end
