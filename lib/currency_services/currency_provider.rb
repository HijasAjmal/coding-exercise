module CurrencyProvider
  
  # this will return all currency rates store in application cofiguration
  # config/currency_rate.yml
  def application_currency_rates
    currency_rates = YAML.load_file('config/currency_rate.yml')
    currency_rates[:rates]
  end
  
  # this will return all the application currency types
  def application_currency_types
    application_currency_rates.collect{ |rate| rate[:currency] }
  end
end
