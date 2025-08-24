# Acme Widget Co Checkout System

A proof of concept for Acme Widget Co's new sales platform.

## Requirements

- Ruby >= 3.0.0

## Products

| Code | Name | Price |
|------|------|-------|
| R01 | Red Widget | $32.95 |
| G01 | Green Widget | $24.95 |
| B01 | Blue Widget | $7.95 |

## Delivery Charges

- Orders under $50: $4.95
- Orders $50-$89.99: $2.95
- Orders $90+: Free delivery

## Special Offers

- **Red Widget Special**: Buy one red widget, get the second half price

## Installation

```bash
git clone <repository-url>
cd acme_widget_checkout_system
bundle install
```

## Testing

Run all test assignments:
```bash
ruby demo.rb
```

Run all tests:
```bash
bundle exec rspec
```

## Usage

The basket implements the required interface:

```ruby
require_relative 'lib/basket'
require_relative 'lib/catalog'
require_relative 'lib/discount_rules/half_price_discount'

# Initialize basket with product catalogue, delivery rules, and offers
basket = Basket.new(catalog: Catalog, discount_rules: [DiscountRules::HalfPriceDiscount.new(product_code: 'R01')])

# Add method takes product code as parameter
basket.add(product_code: 'R01')
basket.add(product_code: 'R01')
basket.add(product_code: 'G01')

# Total method returns total cost including delivery and discounts
puts basket.total 
```

## Assumptions Made

1. **Product Codes**: Case-insensitive, normalized to string
2. **Half-Price Discount**: Applies to every second item
3. **Delivery Calculation**: Based on subtotal after product discounts
4. **Currency Formatting**: Standard dollar format ($XX.XX)
5. **Price Storage**: All prices stored in cents to avoid floating-point precision issues
6. **Discount Priority**: First matching discount rule is applied