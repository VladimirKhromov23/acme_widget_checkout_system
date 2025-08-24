require_relative 'catalog'
require_relative 'services/delivery_calculator'

class Basket
  def initialize(catalog:, discount_rules: [])
    @catalog = catalog
    @discount_rules = discount_rules
    @items = Hash.new(0)
  end

  def add(product_code:)
    validate_product_code!(product_code: product_code)
    @items[product_code.to_s] += 1
  end

  def total
    subtotal = calculate_subtotal
    delivery_charge = DeliveryCalculator.calculate(subtotal_cents: subtotal)
    total_cents = subtotal + delivery_charge

    format_currency(amount_cents: total_cents)
  end

  private

  attr_reader :catalog, :discount_rules, :items

  def validate_product_code!(product_code:)
    unless catalog.exists?(code: product_code)
      raise ArgumentError, "Product '#{product_code}' not found in catalog"
    end
  end

  def calculate_subtotal
    items.sum do |product_code, quantity|
      product = catalog.find(code: product_code)
      applicable_rule = find_applicable_rule(product_code: product_code)

      if applicable_rule
        applicable_rule.calculate(product: product, quantity: quantity)
      else
        quantity * product.price_cents
      end
    end
  end

  def find_applicable_rule(product_code:)
    discount_rules.find { |rule| rule.applies_to?(code: product_code) }
  end

  def format_currency(amount_cents:)
    format('$%.2f', amount_cents / 100.0)
  end
end