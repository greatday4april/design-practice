class MovingAverage
  #     Initialize your data structure here.
  #     :type size: Integer
  def initialize(size)
    @size = size
    @queue = []
    @sum = 0
  end

  #     :type val: Integer
  #     :rtype: Float
  def next(val)
    @queue << val
    @sum += val
    @sum -= @queue.shift if @queue.length > @size
    @sum * 1.0 / @queue.size
  end
end

# Your MovingAverage object will be instantiated and called as such:
# obj = MovingAverage.new(size)
# param_1 = obj.next(val)
