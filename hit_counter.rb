class Tick
  attr_reader :timestamp
  attr_accessor :hit_count
  def initialize(timestamp)
    @timestamp = timestamp
    @hit_count = 1
  end
end


class HitCounter
  #     Initialize your data structure here.
  def initialize
    @time_counter = []
  end

  #     Record a hit.
  #         @param timestamp - The current timestamp (in seconds granularity).
  #     :type timestamp: Integer
  #     :rtype: Void
  def hit(timestamp)
    clean_up(timestamp)
    if @time_counter.last && @time_counter.last.timestamp == timestamp
      @time_counter.last.hit_count += 1
    else
      @time_counter.push(Tick.new(timestamp))
    end
  end

  #     Return the number of hits in the past 5 minutes.
  #         @param timestamp - The current timestamp (in seconds granularity).
  #     :type timestamp: Integer
  #     :rtype: Integer
  def get_hits(timestamp)
    clean_up(timestamp)
    @time_counter.map(&:hit_count).sum
  end

  private
  def clean_up(timestamp)
    @time_counter.shift until @time_counter.empty? || timestamp - @time_counter.first.timestamp < 300
  end
end

# Your HitCounter object will be instantiated and called as such:
# obj = HitCounter.new()
# obj.hit(timestamp)
# param_2 = obj.get_hits(timestamp)
