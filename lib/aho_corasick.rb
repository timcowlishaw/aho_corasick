class AhoCorasick
  def initialize(terms)
    @root = TreeNode.new
    terms.each {|t| unsafe_insert(t)}
    create_suffix_links
  end

  def match(string)
    matches = []
    node = string.each_char.inject(@root) do |node, char|
      matches += node.matches
      node.find(char) || @root
    end
    matches += node.matches
    return matches
  end

  def insert(str)
    unsafe_insert(str)
    create_suffix_links
  end

  private

  def unsafe_insert(str)
    str.each_char.inject(@root) {|node, char| node.child_for(char) }.add_match(str)
  end

  def create_suffix_links
    queue = @root.children.to_a.dup
    while !queue.empty?
      char, node = queue.shift
      node.suffix = node.parent == @root ? @root : node.parent.suffix.children[char]
      node.children.to_a.each do |entry|
        queue.push(entry)
      end
    end
  end

  class TreeNode
    def initialize(parent=nil)
      @parent = parent
      @suffix = nil
      @matches = []
      @children = {}
    end

    attr_reader :matches, :children, :parent
    attr_accessor :suffix


    def find(char)
      @children[char] || (suffix && suffix.find(char))
    end
 
    def add_match(str)
      @matches << str
    end

    def child_for(char)
      @children[char] ||= TreeNode.new(self)
    end

  end
end
