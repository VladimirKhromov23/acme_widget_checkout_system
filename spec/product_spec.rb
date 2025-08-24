require_relative '../lib/product'

RSpec.describe Product do
  describe '#initialize' do
    subject(:product) { described_class.new(code: 'R01', name: 'Red Widget', price: 32.95) }

    it 'creates a product with correct attributes' do
      expect(product.code).to eq('R01')
      expect(product.name).to eq('Red Widget')
      expect(product.price_cents).to eq(3295)
    end

    it 'is immutable after creation' do
      expect(product).to be_frozen
    end
  end

  describe 'validation' do
    it 'raises error for empty code' do
      expect { described_class.new(code: '', name: 'Widget', price: 10.0) }
        .to raise_error(ArgumentError, 'Product code cannot be empty')
    end

    it 'raises error for empty name' do
      expect { described_class.new(code: 'R01', name: '', price: 10.0) }
        .to raise_error(ArgumentError, 'Product name cannot be empty')
    end

    it 'raises error for non-positive price' do
      expect { described_class.new(code: 'R01', name: 'Widget', price: 0) }
        .to raise_error(ArgumentError, 'Price must be a positive number')
    end
  end
end