# frozen_string_literal: true

class OrderedSet
  def initialize
    @hash = {}
  end

  def add(ele)
    @hash[ele] = true
  end

  def delete(ele)
    @hash.delete(ele)
  end

  def shift
    return if empty?

    @hash.shift.first
  end

  def empty?
    @hash.empty?
  end
end

class CacheElement
  attr_accessor :value, :freq
  def initialize(value)
    @value = value
    @freq = 1
  end
end

class LFUCache
  def initialize(capacity)
    @max_capacity = capacity
    @freq_table = Hash.new { |h, k| h[k] = OrderedSet.new }
    @elements = {}
    @min_freq = 0
  end

  def get(key)
    return -1 unless @elements.key?(key)

    element = @elements[key]
    @freq_table[element.freq].delete(key)
    if element.freq == @min_freq
      @min_freq = @freq_table[@min_freq].empty? ?
        @min_freq + 1 : @min_freq
    end

    element.freq += 1
    @freq_table[element.freq].add(key)
    element.value
  end

  def put(key, value)
    if @elements.key?(key)
      get(key)
      @elements[key].value = value
    else
      return if @max_capacity == 0

      if @elements.size == @max_capacity
        min_freq_key = @freq_table[@min_freq].shift
        @min_freq = @freq_table[@min_freq].empty? ?
          @min_freq + 1 : @min_freq
        @elements.delete(min_freq_key)
      end
      @elements[key] = CacheElement.new(value)
      @min_freq = 1
      @freq_table[1].add(key)
    end
  end
end

# Your LFUCache object will be instantiated and called as such:
