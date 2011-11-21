class AhoCorasick
  def initialize(*terms)
    @root = {:matches => [], :children => {}}
    unsafe_insert(terms)
    create_suffix_links
  end

  def match(string)
    matches = []
    node = string.each_char.inject(@root) do |node, char|
      matches += node[:matches] if node
      (node && find(node, char.to_sym)) || find(@root, char.to_sym)
    end
    matches += node[:matches] if node
    return matches
  end

  def insert(*terms)
    unsafe_insert(terms)
    create_suffix_links
  end

  private

  def unsafe_insert(terms)
    terms.each do |t|
      t.each_char.inject(@root) {|node, char| child_for(node, char.to_sym) }[:matches] << t
    end
  end

  def create_suffix_links
    queue = @root[:children].to_a.dup
    while !queue.empty?
      char, node = queue.shift
      node[:suffix] = node[:parent] == @root ? @root : (node[:parent][:suffix] && node[:parent][:suffix][:children][char.to_sym])
      node[:children].to_a.each do |entry|
        queue.push(entry)
      end
    end
  end

  def find(node, char)
    node[:children][char.to_sym] || (node[:suffix] && find(node[:suffix], char.to_sym))
  end
 
   
  def child_for(node, char)
    node[:children][char.to_sym] ||= {:matches => [], :children => {}, :parent => node}
  end
end
