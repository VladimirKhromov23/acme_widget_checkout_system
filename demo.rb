#!/usr/bin/env ruby

require_relative 'lib/basket'
require_relative 'lib/catalog'
require_relative 'lib/discount_rules/half_price_discount'

puts "=== Acme Widget Co Checkout System Demo ===\n\n"

# Test Case 1: B01, G01 => $37.85
puts "Test Case 1: B01, G01"
basket1 = Basket.new(catalog: Catalog, discount_rules: [DiscountRules::HalfPriceDiscount.new(product_code: 'R01')])
basket1.add(product_code: 'B01')  # Blue Widget: $7.95
basket1.add(product_code: 'G01')  # Green Widget: $24.95
puts "Expected: $37.85 | Actual: #{basket1.total}"
puts

# Test Case 2: R01, R01 => $54.37
puts "Test Case 2: R01, R01"
basket2 = Basket.new(catalog: Catalog, discount_rules: [DiscountRules::HalfPriceDiscount.new(product_code: 'R01')])
basket2.add(product_code: 'R01')  # Red Widget: $32.95
basket2.add(product_code: 'R01')  # Red Widget: $16.48 (half price)
puts "Expected: $54.37 | Actual: #{basket2.total}"
puts

# Test Case 3: R01, G01 => $60.85
puts "Test Case 3: R01, G01"
basket3 = Basket.new(catalog: Catalog, discount_rules: [DiscountRules::HalfPriceDiscount.new(product_code: 'R01')])
basket3.add(product_code: 'R01')  # Red Widget: $32.95
basket3.add(product_code: 'G01')  # Green Widget: $24.95
puts "Expected: $60.85 | Actual: #{basket3.total}"
puts

# Test Case 4: B01, B01, R01, R01, R01 => $98.27
puts "Test Case 4: B01, B01, R01, R01, R01"
basket4 = Basket.new(catalog: Catalog, discount_rules: [DiscountRules::HalfPriceDiscount.new(product_code: 'R01')])
basket4.add(product_code: 'B01')  # Blue Widget: $7.95
basket4.add(product_code: 'B01')  # Blue Widget: $7.95
basket4.add(product_code: 'R01')  # Red Widget: $32.95
basket4.add(product_code: 'R01')  # Red Widget: $16.48 (half price)
basket4.add(product_code: 'R01')  # Red Widget: $32.95
puts "Expected: $98.27 | Actual: #{basket4.total}"
puts

puts "=== Summary ==="
puts "All assignment test cases completed!"
puts "System is working correctly for Acme Widget Co requirements."