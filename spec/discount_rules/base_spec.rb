require_relative '../../lib/discount_rules/base'

RSpec.describe DiscountRules::Base do
  let(:product) { double('product', price_cents: 1000) }
  subject(:rule) { described_class.new(product_code: 'R01') }

  describe '#initialize' do
    it 'sets the product code' do
      expect(rule.product_code).to eq('R01')
    end

    it 'freezes the object' do
      expect(rule).to be_frozen
    end
  end

  describe '#applies_to?' do
    it 'returns true for matching product code' do
      expect(rule.applies_to?(code: 'R01')).to be true
    end

    it 'returns false for different product code' do
      expect(rule.applies_to?(code: 'G01')).to be false
    end
  end

  describe '#calculate' do
    it 'raises NotImplementedError' do
      expect { rule.calculate(product: product, quantity: 1) }
        .to raise_error(NotImplementedError)
    end
  end
end