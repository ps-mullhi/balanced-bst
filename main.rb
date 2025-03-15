require_relative 'lib/tree.rb'

tree = Tree.new([5,5,5,1,3,2,2,3,4])
tree2 = Tree.new([1,2,3,4,5,6,7,8,9])

p tree
tree.pretty_print
tree2.pretty_print