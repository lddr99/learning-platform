module Admin
  class Currencies < Grape::API
    desc 'Return currencies.'
    resource 'currencies' do
      get do
        currencies = Currency.all
        Entities::CurrencyEntity.represent(currencies)
      end
    end
  end
end
