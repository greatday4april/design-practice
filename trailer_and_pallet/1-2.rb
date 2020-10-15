# 1.写货物的class 货物的类有两个成员变量(int id, int weight)

# 思路： we will have a class for Pallet
class Pallet
  attr_accessor :id, :weight
  def initialize(id, weight)
    raise 'weight should be positive integer' if weight <= 0
    @id = id
    @weight = weight
  end
end

# 2.写卡车的class,写两个function: load(货物 时间)和unload(货物id，时间)

# 思路： and we can use a hash to store the pallets on the trailer, pallet id as the key, pallet as the values
class Trailer
  attr_accessor :pallet_map
  def initialize
    @pallet_map = {}
  end

  def load(pallet, timestamp)
    raise 'this pallet already loaded' if pallet_map.has_key?(pallet.id)

    @pallet_map[pallet.id] = pallet
  end

  def unload(pallet_id, timestamp)
    raise 'no such pallet' unless @pallet_map.has_key?(pallet_id)

    @pallet_map.delete(pallet_id)
  end
end


# test

trailer = Trailer.new
trailer.load(Pallet.new(1, 100), 100)
trailer.load(Pallet.new(2, 200), 200)
trailer.unload(3, 300) # raise error
