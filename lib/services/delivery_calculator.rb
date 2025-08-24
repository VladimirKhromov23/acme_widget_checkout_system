class DeliveryCalculator
  def self.calculate(subtotal_cents:)
    validate_input!(subtotal_cents)

    case subtotal_cents
    when 9000..Float::INFINITY
      0      # $90+ = free delivery
    when 5000...9000
      295    # $50-$89.99 = $2.95
    when 0...5000
      495    # Under $50 = $4.95
    else
      raise ArgumentError, "Unexpected subtotal: #{subtotal_cents}"
    end
  end

  private

  def self.validate_input!(subtotal_cents)
    unless subtotal_cents.is_a?(Numeric)
      raise ArgumentError, 'Subtotal must be a number'
    end

    if subtotal_cents < 0
      raise ArgumentError, 'Subtotal must be non-negative'
    end
  end
end