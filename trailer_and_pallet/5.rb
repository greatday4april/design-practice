# 5.如果timestamp不是升序的怎么办

# Then we can iterate through all the events and get the sum of weight events from
# all the events happen before the timestamp

class Pallet
  attr_accessor :id, :weight
  def initialize(id, weight)
    raise 'weight should be positive integer' if weight <= 0

    @id = id
    @weight = weight
  end
end

class Event
  attr_accessor :weight_diff, :acc_weight, :timestamp
  def initialize(weight_diff, acc_weight, timestamp)
    @weight_diff = weight_diff
    @acc_weight = acc_weight
    @timestamp = timestamp
  end
end

class Trailer
  attr_accessor :pallet_map, :total_weight, :event_stream
  def initialize(start_time = 0)
    @pallet_map = {}
    @total_weight = 0
    @event_stream = [Event.new(0, 0, start_time)]
  end

  def add_event(weight_diff, timestamp)
    @total_weight += weight_diff
    @event_stream << Event.new(weight_diff, @total_weight, timestamp)
  end

  # find the index of the largest timestamp smaller or equal to the given timestamp
  def find_event_stream_index(timestamp)
    low = 0
    high = @event_stream.length - 1
    while low <= high
      mid = low + (high - low) / 2
      event = @event_stream[mid]
      bigger = event.timestamp <= timestamp
      if bigger
        low = mid + 1
      else
        high = mid - 1
      end
    end

    high
  end

  def getWeightByTimestamp(timestamp) # O(lgn)
    index = find_event_stream_index(timestamp)
    @event_stream[index].acc_weight
  end

  # TODO: ===========begin===========
  def getWeightByTimestampUnordered(timestamp) # O(n)
    @event_stream.sum do |event|
        event.timestamp <= timestamp ? event.weight_diff : 0
    end
  end
  # TODO: ===========end===========

  def load(pallet, timestamp)
    raise 'this pallet already loaded' if pallet_map.has_key?(pallet.id)

    @pallet_map[pallet.id] = pallet
    self.add_event(pallet.weight, timestamp) # TODO
  end

  def unload(pallet_id, timestamp)
    raise 'no such pallet' unless @pallet_map.has_key?(pallet_id)

    pallet = @pallet_map[pallet_id]
    self.add_event(-pallet.weight, timestamp) # TODO
    @pallet_map.delete(pallet_id)
  end
end


# time complexity, assume n is number of pallets, O(1) for load and unload,
# O(n) for getting the weight at given time

# improvements??
# 1. we should make load and unload threadsafe, so for every load and unlock we need to lock the resource for the trailer so we dont have race conditions
# 2. in real world scenarios, the trailer should also have a unique id, and also we need to check
# if a pallet's dimension can fit into the trailer before loading it
# 3. for database management, the pallet data for each trailer should be on the same server as the trailer so it's more efficient

# ======test=====

p1 = Pallet.new(1, 2)
p2 = Pallet.new(2, 3)
p3 = Pallet.new(3, 4)

trailer = Trailer.new()
trailer.load(p1, 100)
puts trailer.total_weight # 2

trailer.load(p2, 200)
puts trailer.total_weight # 5

trailer.load(p3, 500)
puts trailer.total_weight # 9

trailer.unload(p3.id, 700)
puts trailer.total_weight # 5

trailer.unload(p2.id, 800)
puts trailer.total_weight # 2

trailer.unload(p1.id, 900)
puts trailer.total_weight # 0

timestamp = 0
10.times do
    weight = trailer.getWeightByTimestamp(timestamp)
    puts "weight at time #{timestamp}: #{weight}"
    timestamp += 100
end

# TODO: ===========begin===========
p4 = Pallet.new(4, 1000)
trailer.load(p4, 400)
puts trailer.total_weight
timestamp = 0
10.times do
    weight = trailer.getWeightByTimestampUnordered(timestamp)
    puts "weight at time #{timestamp}: #{weight}"
    timestamp += 100
end
# TODO: ===========end===========
