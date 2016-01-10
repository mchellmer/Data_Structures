# Implement binary search tree to build nodes from an array of numbers
# e.g.  [1,3,4,6],7,[8,10,13,14]
#
#           7
#     4         13
#   3   6    10    14
# 1        8

# [1,3,4, 6 ,7,8,9, 10 ,13, 14,15,16]
#              10
#      6               14
#   3     8          13   15
# 1  4  7   9                16
class Node
  def initialize(value)
    @parent = {'value' => value, 'branches'  => {'left' => nil,'right' => nil}}
  end
  
  def left_child(value)
    @parent['branches']['left'] = value
  end
  
  def right_child(value)
    @parent['branches']['right'] = value
  end
  
  def plant_tree
    return @parent
  end
end

def build_tree(array)
  # Base case; array is 3 characters or less, build tree from array
  return array if array.length == 1
  if array.length <= 3
    tree = Node.new(array[1])
    tree.left_child(array.shift)
    array.shift
    tree.right_child(array.shift)
    return tree.plant_tree
  end
  
  # Split array in half, choose middle value as root
  root = array[array.length/2]
  left = build_tree(array[0..array.length/2-1])
  right = build_tree(array[array.length/2+1..-1])
  
  tree = Node.new(root)
  tree.left_child(left)
  tree.right_child(right)
  return tree.plant_tree
end
array = [1,7,4,23,8,9,4,3,5,7,9,67,6345,324]
puts build_tree(value, array)



parent = {'value' => nil, 'branches'  => {'left' => nil,'right' => nil}}
