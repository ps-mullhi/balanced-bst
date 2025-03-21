require_relative 'lib/tree.rb'

tree = Tree.new([1,3,5,7,8,9,10,11,12,13,14,15,16,17])
tree2 = Tree.new([1,2,3,4,5,6,7,8,9])

# p tree
tree.insert(6)
tree.pretty_print
# p tree.find_successor(tree.find(17))
tree.delete(17)
tree.insert(17)
tree.insert(18)
tree.insert(19)
tree.pretty_print

# arr = tree.level_order {|node| puts "Traversed #{node.value}"}
# arr = tree.preorder {|node| puts "Traversed #{node.value}"}
# arr = tree.inorder {|node| puts "Traversed #{node.value}"}
arr = tree.postorder {|node| puts "Traversed #{node.value}"}
p arr
p tree.height
p tree.depth(tree.find(1320))
puts tree.balanced?

tree.rebalance
tree.pretty_print
tree3 = Tree.new([1])
tree3.insert(2)
tree3.insert(3)
tree3.insert(4)
tree3.insert(5)
tree3.insert(6)
tree3.insert(7)
tree3.insert(8)
tree3.insert(9)
tree3.insert(20)
tree3.insert(32)
tree3.pretty_print
tree3.rebalance
tree3.pretty_print
# tree2.pretty_print