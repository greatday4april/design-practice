# frozen_string_literal: true

# ExchangeID,BookIndex,UpdateAction,Side,Price,Quantity

require_relative 'order_book'

order_book_a = OrderBook.new
order_book_b = OrderBook.new
order_book_c = OrderBook.new

open(ARGV[1] || 'output.txt', 'a') do |output_file|
  File.readlines(ARGV[0] || 'input.txt').each do |feed|
    feed_data = feed.split(',').map(&:strip)
    exchange_id = feed_data.shift
    book_index = feed_data.shift.to_i
    update_action = feed_data.shift
    side = feed_data.shift
    if update_action == 'NEW'
      price, quantity = feed_data
      quantity = quantity.to_i
      order_book = exchange_id == 'A' ? order_book_a : order_book_b
      order_book.add_order(book_index, side, price, quantity)
    elsif update_action == 'UPDATE'
      quantity = feed_data.shift.to_i
      order_book = exchange_id == 'A' ? order_book_a : order_book_b
      order_book.update_order(book_index, side, quantity)
    elsif update_action == 'DELETE'

    end

    output_file << order_book_a.bids
  end
end

puts order_book_a.bids
puts order_book_a.offers
