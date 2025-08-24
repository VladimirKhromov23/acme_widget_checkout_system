require_relative '../../lib/services/delivery_calculator'

RSpec.describe DeliveryCalculator do
  describe '.calculate' do
    context 'orders under $50' do
      it 'charges $4.95 delivery' do
        expect(described_class.calculate(subtotal_cents: 0)).to eq(495)      # $0.00
        expect(described_class.calculate(subtotal_cents: 4999)).to eq(495)   # $49.99
      end
    end

    context 'orders $50 to $89.99' do
      it 'charges $2.95 delivery' do
        expect(described_class.calculate(subtotal_cents: 5000)).to eq(295)   # $50.00
        expect(described_class.calculate(subtotal_cents: 8999)).to eq(295)   # $89.99
      end
    end

    context 'orders $90+' do
      it 'charges no delivery' do
        expect(described_class.calculate(subtotal_cents: 9000)).to eq(0)     # $90.00
        expect(described_class.calculate(subtotal_cents: 15000)).to eq(0)    # $150.00
      end
    end

    context 'input validation' do
      it 'raises error for negative amounts' do
        expect { described_class.calculate(subtotal_cents: -1) }
          .to raise_error(ArgumentError, 'Subtotal must be non-negative')
      end

      it 'raises error for non-numeric input' do
        expect { described_class.calculate(subtotal_cents: 'invalid') }
          .to raise_error(ArgumentError, 'Subtotal must be a number')
      end
    end
  end
end