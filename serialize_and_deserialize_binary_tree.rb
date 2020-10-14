# Definition for a binary tree node.
class TreeNode
    attr_accessor :val, :left, :right
    def initialize(val)
        @val = val
        @left, @right = nil, nil
    end
end

# Encodes a tree to a single string.
#
# @param {TreeNode} root
# @return {string}
def serialize(root)
  return 'null' if root.nil?

  [
    root.val,
    serialize(root.left),
    serialize(root.right)
  ].join(',')
end

# Decodes your encoded data to tree.
#
# @param {string} data
# @return {TreeNode}
def deserialize(data)
  TreeDeserializer.new(data.split(',')).deserialize
end

class TreeDeserializer
  def initialize(element_strs)
    @elements = element_strs
  end

  def deserialize()
    element = @elements.shift
    return nil if element == 'null'
    node = TreeNode.new(element)
    node.left = deserialize()
    node.right = deserialize()
    node
  end
end



# Your functions will be called as such:
# deserialize(serialize(data))

root = TreeNode.new(1)
root.left = TreeNode.new(2)
root.right = TreeNode.new(3)
node = deserialize(serialize(root))
puts