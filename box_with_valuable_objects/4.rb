#  PART 4:
#  Implement a method to output the maximum valuable-size in the box whenever the method is called.

# 思路： a naive solution would be to add a instance variable that keeps track of
# the object with maximum size. And update it when adding or removing item

class Valuable
  attr_accessor :id, :name, :size
  def initialize(id, name, size)
    @id = id
    @name = name
    @size = size
  end
end

class Box
  attr_accessor :valuable_map, :max_capacity, :total_size
  def initialize(max_capacity)
    @valuable_map = {}
    @max_capacity = max_capacity
    @total_size = 0
    @max_size_valuable = nil # TODO
  end

  def add_valuable(obj) # time complexity O(1)
    raise 'this valuable already exists' if @valuable_map.has_key?(obj.id)
    raise 'box does not have enough room for this valueable' if @total_size + obj.size > @max_capacity

    @total_size += obj.size

    @valuable_map[obj.id] = obj
    # TODO: ========begin=====
    @max_size_valuable = obj if @max_size_valuable.nil? || obj.size > @max_size_valuable.size
    # TODO: ========end=====
  end

  def remove_valuable(id) # worst case O(n)
    raise 'this valuable doesnt exist' unless @valuable_map.has_key?(id)

    obj = @valuable_map[id] # TODO
    @total_size -= obj.size # TODO
    @valuable_map.delete(id)

    # TODO: ========begin=====
    if !@max_size_valuable.nil? && @max_size_valuable.id == obj.id
      @max_size_valuable = @valuable_map.values.max_by { |valuable| valuable.size }
    end
    # TODO: ========end=====
  end

  # TODO ========begin=====
  def max_size
    @max_size_valuable.size
  end
  # TODO: ========end=====

  # 让你test才需要用 TODO ========begin=====
  def to_s
    valuable = @max_size_valuable
    "box size: #{total_size}\nvaluable with max size: #{valuable.name}, size: #{max_size}"
  end
  # TODO: ========end=====
end

# time complexity for add is O(1), for remove it's O(n) in worst case
# for getting the max value, it's O(1)
# to make the remove more efficient we can also heap  -> 5.rb

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
