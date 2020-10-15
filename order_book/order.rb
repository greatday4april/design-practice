# frozen_string_literal: true

class Order
  attr_reader :price, :side
  attr_accessor :quantity
  def initialize(price, quantity, side)
    @price = price
    @quantity = quantity
    @side = side
  end

  def to_s()
    "#{side} Quantity: #{quantity} Price: #{price}"
  end
end
