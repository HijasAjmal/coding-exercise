namespace :red_hat do
  desc "Updating currency rates with newest rates"
  task update_currency_rates: :environment do
  include CurrencyUpdater
  update_application_currency_rates
end
end
