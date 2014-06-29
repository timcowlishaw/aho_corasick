class AhoCorasick
  def initialize(*terms)
    @root = TreeNode.new
    unsafe_insert(terms)
    create_suffix_links
  end

  def match(string)
    matches = []
    node = string.each_char.inject(@root) do |node, char|
      matches += node.matches if node
      (node && node.find(char.to_sym)) || @root.find(char.to_sym)
    end
    matches += node.matches if node
    return matches
  end

  def insert(*terms)
    unsafe_insert(terms)
    create_suffix_links
  end

  private

  def unsafe_insert(terms)
    terms.each do |t|
      if(t.respond_to? :each)
        unsafe_insert(t)
      else
        t.each_char.inject(@root) {|node, char| node.child_for(char.to_sym) }.add_match(t)
      end
    end
  end

  def create_suffix_links
    queue = @root.children.to_a.dup
    while !queue.empty?
      char, node = queue.shift
      node.suffix = node.parent == @root ? @root : (node.parent.suffix && node.parent.suffix.children[char.to_sym])
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
      @children[char.to_sym] || (suffix && suffix.find(char.to_sym))
    end
 
    def add_match(str)
      @matches << str
    end

    def child_for(char)
      @children[char.to_sym] ||= TreeNode.new(self)
    end

  end
end
