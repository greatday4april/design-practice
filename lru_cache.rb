class ListNode
  attr_accessor :key, :value, :prev, :next
  def initialize(key, value, prev = nil, next_node = nil)
    @key = key
    @value = value
    @prev = prev
    @next = next_node
  end
end

class LRUCache
  #     :type capacity: Integer
  def initialize(capacity)
    @max_capacity = capacity
    @lookup_table = {}
    @dummy_head = ListNode.new(0, 0)
    @tail = @dummy_head
  end

  #     :type key: Integer
  #     :rtype: Integer
  def get(key)
    return -1 unless @lookup_table.key?(key)
    node = @lookup_table[key]
    delete(key)
    self.add(node.key, node.value)
    node.value
  end

  #     :type key: Integer
  #     :type value: Integer
  #     :rtype: Void
  def put(key, value)
    delete(key) if @lookup_table.key?(key)
    self.add(key, value)
  end

  # def print()
  #   node = @dummy_head.next
  #   keys = []
  #   while !node.nil?
  #     keys << node.key
  #     node = node.next
  #   end
  #   puts keys.join(' -> ')
  # end

  protected
  def head
    @dummy_head.next
  end

  def size
    @lookup_table.size
  end

  def add(key, value)
    delete(head.key) if size == @max_capacity
    node = ListNode.new(key, value)
    @tail.next = node
    node.prev = @tail
    @tail = @tail.next
    @lookup_table[node.key] = node
  end

  def delete(key)
    node = @lookup_table[key]
    raise 'there is no element' if node.nil?
    @tail = @tail.prev if node == @tail
    node.prev.next = node.next
    node.next.prev = node.prev unless node.next.nil?
    @lookup_table.delete(key)
    node
  end
end

# Your LRUCache object will be instantiated and called as such:
# obj = LRUCache.new(capacity)
# param_1 = obj.get(key)
# obj.put(key, value)

# Your LRUCache object will be instantiated and called as such:
# obj = LRUCache.new(capacity)
# param_1 = obj.get(key)
# obj.put(key, value)


lRUCache = LRUCache.new(10)
actions = ["put","put","put","put","put","get","put","get","get","put","get","put","put","put","get","put","get","get","get","get","put","put","get","get","get","put","put","get","put","get","put","get","get","get","put","put","put","get","put","get","get","put","put","get","put","put","put","put","get","put","put","get","put","put","get","put","put","put","put","put","get","put","put","get","put","get","get","get","put","get","get","put","put","put","put","get","put","put","put","put","get","get","get","put","put","put","get","put","put","put","get","put","put","put","get","get","get","put","put","put","put","get","put","put","put","put","put","put","put"]
params = [[10,13],[3,17],[6,11],[10,5],[9,10],[13],[2,19],[2],[3],[5,25],[8],[9,22],[5,5],[1,30],[11],[9,12],[7],[5],[8],[9],[4,30],[9,3],[9],[10],[10],[6,14],[3,1],[3],[10,11],[8],[2,14],[1],[5],[4],[11,4],[12,24],[5,18],[13],[7,23],[8],[12],[3,27],[2,12],[5],[2,9],[13,4],[8,18],[1,7],[6],[9,29],[8,21],[5],[6,30],[1,12],[10],[4,15],[7,22],[11,26],[8,17],[9,29],[5],[3,4],[11,30],[12],[4,29],[3],[9],[6],[3,4],[1],[10],[3,29],[10,28],[1,20],[11,13],[3],[3,12],[3,8],[10,9],[3,26],[8],[7],[5],[13,17],[2,27],[11,15],[12],[9,19],[2,15],[3,16],[1],[12,17],[9,1],[6,19],[4],[5],[5],[8,1],[11,7],[5,2],[9,28],[1],[2,2],[7,4],[4,22],[7,24],[9,26],[13,28],[11,26]]

(0...actions.length).each do |idx|
  param = params[idx]
  if actions[idx] == 'put'
    lRUCache.put(*param)
  else
    lRUCache.get(*param)
  end
  lRUCache.print()
end