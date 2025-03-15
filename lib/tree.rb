require_relative './node.rb'

class Tree

  def initialize(array)
    prepped_array = array.uniq.sort
    @root = build_tree(prepped_array, 0, prepped_array.length - 1)
  end

  def insert(new_value, node = @root)
    return if new_value == node.value #not allowing duplicates

    if node.left.nil? && new_value < node.value
      node.left = Node.new(new_value)
    elsif node.right.nil? && new_value > node.value
      node.right = Node.new(new_value)
    else
      if new_value < node.value
        insert(new_value, node.left)
      else
        insert(new_value, node.right)
      end
    end
  end

  def delete(value)
    node, parent = find_node_plus_parent(value)
    
    return if node.nil?

    if node.leaf?
      if node == parent.left
        parent.left = nil
      else
        parent.right = nil
      end
    elsif node.one_child?
      child = node.left || node.right
      replace_node_with_child(parent, node, child)
    else # has both children
      successor = find_successor(node)
      delete(successor.value)
      node.value = successor.value
    end
  end

  def find(value, node = @root)
    if node.nil?
      nil
    elsif value == node.value
      node
    else
      if value < node.value
        find(value, node.left)
      else
        find(value, node.right)
      end
    end
  end

  def level_order
    return if @root.nil? 

    queue = Queue.new
    queue.push(@root)

    arr = []
    until queue.empty?
      node = queue.pop
      if block_given?
        yield(node)
      else
        arr << node.value
      end
      queue.push(node.left) if node.left.nil? == false
      queue.push(node.right) if node.right.nil? == false
    end

    unless block_given?
      arr
    end
  end

  def preorder(node = @root, arr = [], &block)
    return if node.nil?

    if block_given?
      block.call(node)
    else
      arr << node.value
    end
    
    preorder(node.left, arr, &block)
    preorder(node.right, arr, &block)
    
    unless block_given?
      arr
    end
  end

  def inorder(node = @root, arr = [], &block)
    return if node.nil?
    
    inorder(node.left, arr, &block)
    if block_given?
      block.call(node)
    else
      arr << node.value
    end
    inorder(node.right, arr, &block)
    
    unless block_given?
      arr
    end
  end

  def postorder(node = @root, arr = [], &block)
    return if node.nil?
    
    postorder(node.left, arr, &block)
    postorder(node.right, arr, &block)
    if block_given?
      block.call(node)
    else
      arr << node.value
    end
    
    unless block_given?
      arr
    end
  end

  def height(node = @root)
    return -1 if node.nil?

    return 1 + [height(node.left), height(node.right)].max
  end

  def depth(node, current = @root, depth = 0)
    if node.nil?
      -1
    elsif node == current
      depth
    else
      if node < current
        depth(node, current.left, depth + 1)
      else
        depth(node, current.right, depth + 1)
      end
    end
  end

  def balanced?
    arr = []
    level_order {|node| arr << node_balanced?(node)}

    arr.any?(false) ? false : true
  end

  def rebalance 
    all_values = self.inorder
    prepped_values = all_values.uniq.sort
    @root = build_tree(prepped_values, 0, prepped_values.length - 1)
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
  
  def find_node_plus_parent(value, node=@root, parent=nil)
    if node.nil?
      [nil, nil]
    elsif value == node.value
      [node, parent]
    else
      if value < node.value
        find_node_plus_parent(value, node.left, node)
      else
        find_node_plus_parent(value, node.right, node)
      end
    end
  end

  def find_successor(node)
    successor = node.right
    
    return nil if successor.nil?

    until successor.left.nil?
      successor = successor.left 
    end

    successor
  end
  
  def replace_node_with_child(parent, node, child)
    if parent.nil?
      @root = child
    elsif node == parent.left
      parent.left = child
    else
      parent.right = child
    end
  end

  def node_balanced?(node)
    (height(node.left) - height(node.right)).abs <= 1
  end
 
end