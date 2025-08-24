require_relative '../../lib/product'
require_relative '../../lib/discount_rules/half_price_discount'

RSpec.describe DiscountRules::HalfPriceDiscount do
  let(:red_widget) { Product.new(code: 'R01', name: 'Red Widget', price: 32.95) }
  subject(:discount) { described_class.new(product_code: 'R01') }

  describe '#initialize' do
    it 'sets product code to R01' do
      expect(discount.product_code).to eq('R01')
    end

    it 'freezes the object' do
      expect(discount).to be_frozen
    end
  end

  describe '#calculate' do
    context 'edge cases' do
      it 'returns 0 for 0 items' do
        expect(discount.calculate(product: red_widget, quantity: 0)).to eq(0)
      end

      it 'returns full price for 1 item' do
        expect(discount.calculate(product: red_widget, quantity: 1)).to eq(3295)
      end
    end

    context 'discount scenarios' do
      it 'calculates 2 items: full + half price' do
        # $32.95 + $16.48 = $49.43
        expected = 3295 + (3295 / 2)
        expect(discount.calculate(product: red_widget, quantity: 2)).to eq(expected)
      end

      it 'calculates 3 items: full + half + full price' do
        # $32.95 + $16.48 + $32.95 = $82.38
        expected = 3295 + (3295 / 2) + 3295
        expect(discount.calculate(product: red_widget, quantity: 3)).to eq(expected)
      end
    end
  end
end