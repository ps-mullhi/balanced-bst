class Node
  include Comparable
  attr_accessor :left, :right
  attr_reader :value

  def initialize(value, left = nil, right = nil)
    @value = value
    @left = left
    @right = right
  end

  def <=>(other)
    Node.value <=> other.value
  end
end