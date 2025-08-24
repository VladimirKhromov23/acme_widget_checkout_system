module DiscountRules
  class Base
    attr_reader :product_code

    def initialize(product_code:)
      @product_code = product_code.to_s
      freeze
    end

    def applies_to?(code:)
      product_code == code.to_s
    end

    def calculate(product:, quantity:)
      raise NotImplementedError, "subclasses of DiscountRules::Base must implement #calculate"
    end

    private

    def validate_quantity!(quantity:)
      unless quantity.is_a?(Integer) && quantity >= 0
        raise ArgumentError, 'Quantity must be a non-negative integer'
      end
    end
  end
end