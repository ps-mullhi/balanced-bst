require_relative './node.rb'

class Tree

  def initialize(array)
    prepped_array = array.uniq.sort
    @root = build_tree(prepped_array, 0, prepped_array.length - 1)
  end

  # not my method. Odin Project student shared on discord, and linked in project description
  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.value}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

  private

  def build_tree(array, start_i, end_i)
    return nil if end_i < start_i 

    mid_i = (start_i + end_i) / 2
    root_node = Node.new(array[mid_i])

    root_node.left = build_tree(array, start_i, mid_i - 1)
    root_node.right = build_tree(array, mid_i + 1, end_i)
    
    root_node
  end

 
end