# frozen_string_literal: true

# part1 题目的输入是List<Element>， 其中Element代表了一行HTML,  让你根据这些Element的相互关系建树。比如
#
# Element0: <loop>
# Element1: <text>names</text>
# Element2: </loop>
#
# 那么在树中Element1显然就是Element0的child。Element2代表从Element0的subtree中返回。

# 和面试官澄清: is it garaunteed that in this list, each HTML string is not nested. for example element1 wont have two different html tags such as <div><h1>hello</h1></div>

# 思路： we can create a DOMNode class and a DOMTree class, the DOMTree will have a DOMNode as root
# and then we can take the list of elements and iterate through it. If we see a leaf node then we just add it as a child, but if we see a open html tag, then we can recursively get all the children DOMNoes, until we hit the close tag. In the end we will have a DOMTree with DOMNodes.

class DOMNode
  attr_accessor :tag, :children, :content
  def initialize(tag, content = nil)
    @tag = tag
    @content = content # is leaf
    @children = []
  end

  def add_child(child)
    @children << child
  end
end

class DOMTree
  def initialize(elements)
    @idx = 0
    @elements = elements
    @root = DOMNode.new('html')
    @root.children = add_elements
  end

  def add_elements # return array of DOMNode
    nodes = []
    until @elements.empty?
      element = @elements.shift
      return nodes if element.start_with?('</') # this is close tag

      left_bracket_index = element.index('<')
      right_bracket_index = element.index('>')
      tag = element[left_bracket_index + 1...right_bracket_index]

      close_tag_index = element.index("</#{tag}>")
      # has close tag, this element is leaf
      if !close_tag_index.nil?
        nodes << DOMNode.new(tag, element[right_bracket_index + 1...close_tag_index])
      else
        node = DOMNode.new(tag)
        node.children = add_elements
        nodes << node
      end
    end
    nodes
  end

  def to_html(node = @root)
    return if node.nil?

    strs = ["<#{node.tag}>"] # open tag

    children_html = node.children.map { |child| to_html(child) }
    strs = strs.concat(children_html)
    strs << node.content unless node.content.nil?

    strs << "</#{node.tag}>" # close tag
    strs.join
  end
end

# 仅用于test
elements = ['<div>', '<text>names</text>', '</div>']
tree = DOMTree.new(elements)
p tree.to_html

elements = ['<div>', '<p>', '<text>names</text>', '</p>', '<h1>hello</h1>' '</div>', '<div>']
tree = DOMTree.new(elements)
p tree.to_html
