class Product
  attr_reader :code, :name, :price_cents

  def initialize(code:, name:, price:)
    @code = validate_code!(code)
    @name = validate_name!(name)
    @price_cents = validate_price!(price)
    freeze
  end

  private

  def validate_code!(code)
    code_str = code.to_s.strip
    raise ArgumentError, 'Product code cannot be empty' if code_str.empty?
    code_str
  end

  def validate_name!(name)
    name_str = name.to_s.strip
    raise ArgumentError, 'Product name cannot be empty' if name_str.empty?
    name_str
  end

  def validate_price!(price)
    raise ArgumentError, 'Price must be a positive number' unless price.is_a?(Numeric) && price > 0
    (price * 100).round
  end
end