class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include CurrencyProvider

  # will return the updated currency rates from the application
  # only for specified currency type in the task
  def fetch_currency_rates
    begin
      application_currency_rates
    rescue Exception => e
      render :file => "#{Rails.root}/public/404.html", :status => :not_found
    end
  end
end
