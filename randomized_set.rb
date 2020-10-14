class RandomizedSet
  #     Initialize your data structure here.
  def initialize
    @number_index_map = {}
    @number_list = []
  end

  #     Inserts a value to the set. Returns true if the set did not already contain the specified element.
  #     :type val: Integer
  #     :rtype: Boolean
  def insert(val)
    return false if @number_index_map.key?(val)
    @number_list << val
    @number_index_map[val] = @number_list.length - 1
    true
  end

  #     Removes a value from the set. Returns true if the set contained the specified element.
  #     :type val: Integer
  #     :rtype: Boolean
  def remove(val)
    return false unless @number_index_map.key?(val)
    index = @number_index_map[val]
    last_element = @number_list[-1]
    @number_list[index] = last_element

    @number_list.pop
    @number_index_map[last_element] = index
    @number_index_map.delete(val)
    true
  end

  #     Get a random element from the set.
  #     :rtype: Integer
  def get_random
    @number_list[Random.new.rand(@number_list.length)]
  end
end

# Your RandomizedSet object will be instantiated and called as such:
# obj = RandomizedSet.new()
# param_1 = obj.insert(val)
# param_2 = obj.remove(val)
# param_3 = obj.get_random()
puts
