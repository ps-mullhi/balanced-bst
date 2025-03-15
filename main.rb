require_relative 'lib/tree.rb'

tree = Tree.new([1,3,5,7,8,9,10,11,12,13,14,15,16,17])
tree2 = Tree.new([1,2,3,4,5,6,7,8,9])

# p tree
tree.insert(6)
tree.pretty_print
# p tree.find_successor(tree.find(17))
tree.delete(17)
tree.pretty_print

arr = tree.level_order {|node| puts "Traversed #{node.value}"}

# tree2.pretty_print