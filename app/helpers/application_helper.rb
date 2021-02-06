module ApplicationHelper
  include CurrencyProvider

  # loading assets based on controller name for simple and more customizable use
  def asset_present?(name)
    if Rails.application.assets.present?
      Rails.application.assets.find_asset(name)
    else
      Rails.application.assets_manifest.files.values.map { |v| v['logical_path'] }.include?(name)
    end
  end
  
  # fetch application currency types
  def fetch_application_currency_types
    application_currency_types
  end
end
