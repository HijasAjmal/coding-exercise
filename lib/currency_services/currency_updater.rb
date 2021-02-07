require 'yaml'
require 'open-uri'

module CurrencyUpdater

  # this is the url which is providing updated currency rates
  CURRENCY_URL = "https://www.ecb.europa.eu/stats/eurofxref/eurofxref-hist-90d.xml"
  
  # define currency type which we need to fetch from the provided url
  # modify with new currency type if you want to add new currency type
  CURRENCY_TYPES = %w(GBP PHP USD)
  
  # this will update currency rate config file under ("config/currency_rate.yml")
  # currency_rate.yml will be the newest currency rates in the application
  def update_application_currency_rates
    xml_document = open(CURRENCY_URL)
    hash = Hash.from_xml(xml_document.read)
    date_rates = hash["Envelope"].try(:[], "Cube").try(:[], "Cube")
    yaml = generating_currency_details(date_rates).to_yaml
    File.open("config/currency_rate.yml", "w") { |file| file.write(yaml) }
  end
  
  # here generating currency details for each type of currency specified in the CURRENCY_TYPES
  # currency details will include only (currency name, currency rate)
  def generating_currency_details(date_rate_collections)
    currency_rates_hash = {}
    currency_details = []
    currency_rates = date_rate_collections.sort_by{|f| f[:time]}.first
    currency_rates_hash[:time] = currency_rates["time"]
    currency_rates["Cube"].each do |currency|
      currency_details <<
          {
              :currency => currency["currency"],
              :rate => currency["rate"]
          } if CURRENCY_TYPES.include?currency["currency"].to_s
    end
    currency_rates_hash[:rates] = currency_details
    currency_rates_hash
  end
end
