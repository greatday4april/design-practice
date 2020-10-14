require_relative 'lib/heap/heap'

class MedianFinder
  #     initialize your data structure here.
  def initialize
    @larger_half = MinHeap.new  # the larger half
    @smaller_half = MaxHeap.new  # the smaller half
  end

  #     :type num: Integer
  #     :rtype: Void
  def add_num(num)
    @smaller_half << num
    @larger_half << @smaller_half.pop
    @smaller_half << @larger_half.pop if @smaller_half.size < @larger_half.size
  end

  #     :rtype: Float
  def find_median
    if @larger_half.size == @smaller_half.size
      (@smaller_half.peak + @larger_half.peak) * 0.5
    else
      @smaller_half.peak
    end
  end
end

# Your MedianFinder object will be instantiated and called as such:
# obj = MedianFinder.new()
# obj.add_num(num)
# param_2 = obj.find_median()
