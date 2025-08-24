require_relative '../lib/basket'
require_relative '../lib/catalog'
require_relative '../lib/discount_rules/half_price_discount'

RSpec.describe Basket do
  let(:catalog) { Catalog }
  let(:half_price_discount) { DiscountRules::HalfPriceDiscount.new(product_code: 'R01') }

  describe '#initialize' do
    subject(:basket) { described_class.new(catalog: catalog) }

    it 'creates an empty basket' do
      expect(basket.total).to eq('$4.95')
    end
  end

  describe '#add' do
    subject(:basket) { described_class.new(catalog: catalog) }

    context 'with valid product codes' do
      it 'adds products to basket' do
        expect { basket.add(product_code: 'R01') }.not_to raise_error
        expect { basket.add(product_code: 'G01') }.not_to raise_error
        expect { basket.add(product_code: 'B01') }.not_to raise_error
      end
    end

    context 'with invalid product code' do
      it 'raises descriptive error' do
        expect { basket.add(product_code: 'INVALID') }
          .to raise_error(ArgumentError, "Product 'INVALID' not found in catalog")
      end
    end
  end

  describe '#total' do
    context 'without discount rules' do
      subject(:basket) { described_class.new(catalog: catalog) }

      before do
        basket.add(product_code: 'B01')
        basket.add(product_code: 'G01')
      end

      it 'calculates simple totals' do
        expect(basket.total).to eq('$37.85')
      end
    end

    context 'with half price discount' do
      subject(:basket) { described_class.new(catalog: catalog, discount_rules: [half_price_discount]) }

      before do
        basket.add(product_code: 'R01')
        basket.add(product_code: 'R01')
      end

      it 'applies discount to red widgets' do
        expect(basket.total).to eq('$54.37')
      end
    end
  end

  describe 'Assignment test cases' do
    subject(:basket) { described_class.new(catalog: catalog, discount_rules: [half_price_discount]) }

    context 'when B01, G01' do
      before do
        basket.add(product_code: 'B01')
        basket.add(product_code: 'G01')
      end

      it 'calculates total for B01, G01 => $37.85' do
        expect(basket.total).to eq('$37.85')
      end
    end

    context 'when R01, R01' do
      before do
        basket.add(product_code: 'R01')
        basket.add(product_code: 'R01')
      end

      it 'calculates total for R01, R01 => $54.37' do
        expect(basket.total).to eq('$54.37')
      end
    end

    context 'when R02, R01' do
      before do
        basket.add(product_code: 'R01')
        basket.add(product_code: 'G01')
      end

      it 'calculates total for R01, G01 => $60.85' do
        expect(basket.total).to eq('$60.85')
      end
    end

    context 'when B01, B01, R01, R01, R01' do
      before do
        basket.add(product_code: 'B01')
        basket.add(product_code: 'B01')
        basket.add(product_code: 'R01')
        basket.add(product_code: 'R01')
        basket.add(product_code: 'R01')
      end

      it 'calculates total for B01, B01, R01, R01, R01 => $98.27' do
        expect(basket.total).to eq('$98.27')
      end
    end
  end
end