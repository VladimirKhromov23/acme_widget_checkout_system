require_relative 'product'

module Catalog
  PRODUCTS = {
    'R01' => Product.new(code: 'R01', name: 'Red Widget', price: 32.95),
    'G01' => Product.new(code: 'G01', name: 'Green Widget', price: 24.95),
    'B01' => Product.new(code: 'B01', name: 'Blue Widget', price: 7.95)
  }.freeze

  def self.find(code:)
    PRODUCTS[code.to_s]
  end

  def self.exists?(code:)
    PRODUCTS.key?(code.to_s)
  end
end