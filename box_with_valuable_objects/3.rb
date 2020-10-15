#  PART3:
#  Add an **maximum size bar** to the representation of box. Modify the add method so that if the total size of valuables in the box will exceed the box size bar, do not add and print an error message. Otherwise, add the valuable into the box.

# 思路： we can add a max_capacity instance variable to the box, and also a number represents total_size of the valuables. So at the time of adding, we can check if the size will exceed

class Valuable
  attr_accessor :id, :name, :size # TODO
  def initialize(id, name, size) # TODO
    @id = id
    @name = name
    @size = size # TODO
  end
end

class Box
  attr_accessor :valuable_map, :max_capacity, :total_size # TODO
  def initialize(max_capacity) # TODO
    @valuable_map = {}
    @max_capacity = max_capacity # TODO
    @total_size = 0 # TODO
  end

  def add_valuable(obj)
    raise 'this valuable already exists' if @valuable_map.has_key?(obj.id)
    # TODO: ========begin=====
    if @total_size + obj.size > @max_capacity
      raise 'box does not have enough room for this valueable'
    end

    @total_size += obj.size # TODO
    # TODO ========end=====

    @valuable_map[obj.id] = obj
  end

  def remove_valuable(id)
    raise 'this valuable doesnt exist' unless @valuable_map.has_key?(id)

    @total_size -= @valuable_map[id].size # TODO
    @valuable_map.delete(id)
  end

  # 让你test才需要用 TODO ========begin=====
  def to_s
    "box size: #{@total_size}\n"
  end
  # TODO: ========end=====
end

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
