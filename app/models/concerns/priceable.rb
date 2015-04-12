module Priceable
  extend ActiveSupport::Concern

  def price_to_number price
    price.gsub('R$ ', '').gsub('.', '').gsub(',', '.')
  end

end
