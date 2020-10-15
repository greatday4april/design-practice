#  PART 5.
#  Implement a method to output the maximum valuable-size in the box whenever the method is called.

# 5. we can have a max heap based on object size and maintain this heap
# so we can make remove function more efficient

# ruby doesnt have heap so can I copy the code for heap from my own github?
# let me find it..
# >>>>>> 拷贝 @@heap.rb 里的内容
class Valuable
  attr_accessor :id, :name, :size
  def initialize(id, name, size)
    @id = id
    @name = name
    @size = size
  end

  def >=(another)
    size >= another.size
  end
end

class Box
  attr_accessor :valuable_map, :max_capacity, :total_size
  def initialize(max_capacity)
    @valuable_map = {}
    @max_capacity = max_capacity
    @total_size = 0
    @max_size_heap = MaxHeap.new # TODO
  end

  def add_valuable(obj) # time complexity O(lgn)
    raise 'this valuable already exists' if @valuable_map.has_key?(obj.id)
    raise 'box does not have enough room for this valueable' if @total_size + obj.size > @max_capacity

    @total_size += obj.size

    @valuable_map[obj.id] = obj
    # TODO: ========begin=====
    @max_size_heap << obj
    # TODO: ========end=====
  end

  def remove_valuable(id) # time complexity O(lgn) on average
    raise 'this valuable doesnt exist' unless @valuable_map.has_key?(id)

    obj = @valuable_map[id] # TODO
    @total_size -= obj.size # TODO
    @valuable_map.delete(id)

    # TODO: ========begin=====
    # if the top item is deleted then we should keep popping until the top item does exist
    while !@valuable_map.has_key?(@max_size_heap.peak.id)
      @max_size_heap.pop
    end
    # TODO: ========end=====
  end

  # TODO ========begin=====
  def max_size
    @max_size_heap.peak.size
  end
  # TODO: ========end=====

  # 让你test才需要用
  def to_s
    valuable = @max_size_heap.peak # TODO
    "box size: #{total_size}\nvaluable with max size: #{valuable.name}, size: #{max_size}"
  end
end

# time complexity for add is O(lgn), for remove it's O(lgn) as well (because if we are removing n items then at most we are removing from heap n times, and each time its' O(lgn) )
# for getting the max value, it's still O(1)

# improvements??
# 1. we should make add and remove threadsafe, so for every add and remove we need to lock the resource for the box so we dont have race conditions
# 2. in real world scenarios, the box should also have a unique id, and also we need to check
# if a object's dimension can fit into the box before adding it
# 3. for database management, the object data for each box should be on the same server as the box so it's more efficient


# test

box = Box.new(1200) # TODO
v1 = Valuable.new(1, 'ruby', 200) # TODO
v2 = Valuable.new(2, 'painting', 500) # TODO
v3 = Valuable.new(3, 'gold', 300) # TODO

begin
  box.add_valuable(v1)
  puts box
  box.add_valuable(v2)
  puts box
  box.add_valuable(v3)
  puts box
  box.remove_valuable(2)
  puts box
  box.remove_valuable(4)
  puts box
rescue StandardError => e
  p e.message
end
