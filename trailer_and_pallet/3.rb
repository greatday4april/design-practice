# 3.给货车设计一个API计算它在当前时刻的载重: getWeight

# 思路: we can use a instance variable to keep track of the total weight for the trailer, and just return that variable when we want to getWeight
# time and space complexity O(1)

class Pallet
  attr_accessor :id, :weight
  def initialize(id, weight)
    raise 'weight should be positive integer' if weight <= 0
    @id = id
    @weight = weight
  end
end

class Trailer
  attr_accessor :pallet_map, :total_weight  # TODO
  def initialize
    @pallet_map = {}
    @total_weight = 0 # TODO
  end

  def load(pallet, timestamp)
    raise 'this pallet already loaded' if pallet_map.has_key?(pallet.id)

    @pallet_map[pallet.id] = pallet
    @total_weight += pallet.weight # TODO
  end

  def unload(pallet_id, timestamp)
    raise 'no such pallet' unless @pallet_map.has_key?(pallet_id)

    pallet = @pallet_map[pallet_id] # TODO
    @total_weight -= pallet.weight # TODO
    @pallet_map.delete(pallet_id)
  end
end

# test

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