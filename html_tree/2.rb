# frozen_string_literal: true

# Part2：在给定Part1的基础上，给一个JsonObject作为从后端获得的数据，渲染part1的HTML。

# 网页前端接收到后端数据后的HTML渲染问题。据楼主所知DOM是个树状结构，因此这道题目也要求对页面上的元素建树，然后在（划重点)给定页面结构的情况下，要parse一个后端传过来的Json输出所有渲染过的HTML。比如说一个元素<loop>name</loop> 那么json里有几个name就得输出几个name。

# 思路, we can do dfs in this DOMTree and visit all the nodes, if the content matches,
# then we replace the content with the value from json

require 'json' # TODO

class DOMNode
  attr_accessor :tag, :children, :content
  def initialize(tag, content = nil)
    @tag = tag
    @content = content
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
    @json = {}
  end

  # TODO: ========begin=====
  def json=(json_str)
    @json = JSON.parse(json_str)
    traverse
  end

  def traverse(node = @root)
    return if node.nil?

    old_content = node.content
    if !old_content.nil? && @json.key?(old_content)
      node.content = @json[old_content]
    end
    node.children.each do |child|
      traverse(child)
    end
  end
  # TODO: ========end=====

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

# test
elements = ['<div>', '<text>names</text>', '</div>']
tree = DOMTree.new(elements)
p tree.to_html

elements = ['<div>', '<p>', '<text>names</text>', '</p>', '<h1>hello</h1>' '</div>']
tree = DOMTree.new(elements)
p tree.to_html

# TODO: ========begin=====
tree.json = JSON.dump({ 'names' => 'April', 'hello' => 'hey' })
p tree.to_html
# TODO: ========end=====
