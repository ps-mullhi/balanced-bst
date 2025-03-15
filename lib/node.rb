class Node
  include Comparable
  attr_accessor :left, :right, :value

  def initialize(value, left = nil, right = nil)
    @value = value
    @left = left
    @right = right
  end

  def <=>(other)
    return nil if other.nil?
    self.value <=> other.value
  end

  def leaf?
    self.left.nil? && self.right.nil?
  end

  def one_child?
    (self.left.nil? && !self.right.nil?) || (!self.left.nil? && self.right.nil?)
  end

  def both_children?
    !self.left.nil? && !self.right.nil?
  end
end