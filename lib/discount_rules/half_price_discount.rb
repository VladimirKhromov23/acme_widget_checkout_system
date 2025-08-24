require_relative 'base'

module DiscountRules
  class HalfPriceDiscount < Base
    def initialize(product_code:)
      super(product_code: product_code)
      freeze
    end

    def calculate(product:, quantity:)
      validate_quantity!(quantity: quantity)
      return 0 if quantity <= 0
      return product.price_cents if quantity == 1

      full_price_count = (quantity + 1) / 2
      half_price_count = quantity - full_price_count

      (full_price_count * product.price_cents) + (half_price_count * product.price_cents / 2)
    end
  end
end