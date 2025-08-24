require_relative '../lib/catalog'

RSpec.describe Catalog do
  describe '.find' do
    it 'returns the correct product for valid code' do
      product = described_class.find(code: 'R01')
      expect(product.code).to eq('R01')
      expect(product.name).to eq('Red Widget')
      expect(product.price_cents).to eq(3295)
    end

    it 'returns nil for invalid code' do
      expect(described_class.find(code: 'INVALID')).to be_nil
    end
  end

  describe '.exists?' do
    it 'returns true for existing products' do
      expect(described_class.exists?(code: 'G01')).to be true
    end

    it 'returns false for non-existing products' do
      expect(described_class.exists?(code: 'INVALID')).to be false
    end
  end
end