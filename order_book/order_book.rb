# frozen_string_literal: true

require_relative 'order'

class OrderBook
  attr_reader :bids, :offers
  def initialize
    @bids = []
    @offers = []
  end

  def find_index_by_price(side, price); end

  def add_order(book_index, side, price, quantity)
    if side == 'BID'
      @bids = @bids[0...book_index] + [Order.new(price, quantity, side)] + @bids[book_index..-1]
    else
      @offers = @offers[0...book_index] + [Order.new(price, quantity, side)] + @offers[book_index..-1]
    end
  end

  def update_order(book_index, side, quantity)
    orders = side == 'BID' ? @bids : @offers
    orders[book_index].quantity = quantity
    # if side == 'BID'
    #   @bids[book_index].quantity = quantity
    # else
    #   @offers[book_index].quantity = quantity
    # end
  end

  def delete_order(book_index); end
end
