# 从卡车变成往盒子里面装珠宝 换汤不换药

# 1. Implement a representation of valuable with two fields id and name.
# 思路：create a Valuable class with two fields id and name. 同时还要有constructor， 因为面试官让我自己写test cases.

class Valuable
  attr_accessor :id, :name
  def initialize(id, name)
    @id = id
    @name = name
  end
end

#  PART 2:
#  Implement a representation of box, which is used as a container of valuables.
#  Implement two methods. First is to add a valuable to the box (given id as input). Second is to remove a valuable from the box(given valuable object as input).

# 思路：and we can use a hash to store the valuables, valuable id as key and valuable object as the value

class Box
  attr_accessor :valuable_map
  def initialize
    @valuable_map = {}
  end

  def add_valuable(obj)
    raise 'this valuable already exists' if @valuable_map.has_key?(obj.id)

    @valuable_map[obj.id] = obj
  end

  def remove_valuable(id)
    raise 'this valuable doesnt exist' unless @valuable_map.has_key?(id)

    @valuable_map.delete(id)
  end
end

# time complexity for both add and remove are O(1)
# assume there are n valuable objects, then space complexity is O(n)

# test

box = Box.new
v1 = Valuable.new(1, 'ruby')
v2 = Valuable.new(2, 'painting')
v3 = Valuable.new(3, 'gold')

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
