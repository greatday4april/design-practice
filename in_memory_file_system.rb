class InMemoryFile
  attr_accessor :name, :content
  def initialize(name, content="")
    @name = name
    @content = content
  end

  def ls()
    [name]
  end

  def add_content(more_content)
    @content += more_content
  end
end

class Directory
  attr_accessor :children, :name
  def initialize(name)
    @name = name
    @children = {}
  end

  def ls()
    children.values.map(&:name).sort
  end

  def mkdir(name)
    return if @children.key?(name)
    children[name] = Directory.new(name)
  end

  def add_content_to_file(name, content)
    children[name] = InMemoryFile.new(name) unless children.key?(name)
    children[name].add_content(content)
  end
end


class FileSystem
  def initialize
    @root = Directory.new(nil)
  end

  #     :type path: String
  #     :rtype: String[]
  def ls(path)
    names = path.split('/')
    names.shift
    node = @root
    until names.empty?
      node = node.children[names.shift]
    end
    node.ls
  end

  #     :type path: String
  #     :rtype: Void
  def mkdir(path)
    names = path.split('/')
    names.shift
    node = @root
    until names.empty?
      name = names.shift
      node.mkdir(name) unless node.children.key?(name)
      node = node.children[name]
    end
    node
  end

  #     :type file_path: String
  #     :type content: String
  #     :rtype: Void
  def add_content_to_file(file_path, content)
    names = file_path.split('/')
    file_name = names.pop
    directory = self.mkdir(names.join('/'))
    directory.add_content_to_file(file_name, content)
  end

  #     :type file_path: String
  #     :rtype: String
  def read_content_from_file(file_path)
    names = file_path.split('/')
    file_name = names.pop
    directory = self.mkdir(names.join('/'))
    directory.children[file_name].content
  end
end

# Your FileSystem object will be instantiated and called as such:
system = FileSystem.new()
p system.ls('/')
p system.mkdir('/a/b/c')
p system.add_content_to_file('/a/b/c/d', 'hello')
p system.ls('/')
p system.read_content_from_file('/a/b/c/d')