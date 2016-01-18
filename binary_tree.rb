# Implement binary search tree to build nodes from an array of numbers
# e.g.  [1,3,4,6],7,[8,10,13,14]          [14,4,7,8,10,3,1,6,13]
#
#           7                                       10
#     4          13                          7               6
#   3   6     10    14                    4     8         1      13
# 1          8                        14               3

# e.g.  [1,3,4,6],7,[8,10,13,14]          [14, 4,7,8, 10 ,3,1,6, 13]
#
#           7                                          3
#     4          13                              7            10
#   3   6     10    14                         4   8        1   6
# 1          8


# [1,3,4, 6 ,7,8,9, 10 ,13, 14,15,16]
#              10
#      6               14
#   3     8          13   15
# 1  4  7   9                16
def merge_sort(array)
  return array if array.length == 1

  # Divide & conquer
  half1 = merge_sort(array[0..array.length/2 - 1])
  half2 = merge_sort(array[array.length/2..-1])

  # Initialize result array
  sorted = []
  
  while half1.length > 0 && half2.length > 0
    if half1[0] <= half2[0]
      sorted << half1.shift
    else
      sorted << half2.shift
    end
  end
  if half1.length > 0
    sorted.concat half1
  elsif half2.length > 0
    sorted.concat half2
  end
  
  return sorted
end

class Node
  def initialize(value)
    @node = {'value' => value,
            'branches'  => {'left' => nil,'right' => nil}
            }
  end
  
  def left_child(value)
    @node['branches']['left'] = value
  end
  
  def right_child(value)
    @node['branches']['right'] = value
  end
  
  def plant_tree
    return @node
  end
end

def build_tree(array)
  if defined?(tree).nil?
    0.upto(array.length-2) do |val|
      if array[val] > array[val+1]
          array = merge_sort(array)
          break
      end
    end
    
    holder = []
    0.upto(array.length-2) do |val|
      holder << array[val] unless array[val] == array[val+1]
    end
    array = holder
  end
  
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


class Crawler
  def initialize(tree,value)
    @stack = [tree]
    @value = value
    @read = []
  end
  
  ## Depth first traversal
  # build a stack: check root, add to stack; check left add to stack unless nil then check right
  # pick least branch
  def dfs(tree)
    # Return the tree if the root value matches the search value
    if @stack[-1].nil?
      return nil
    elsif @stack[-1]['value'] == @value || @stack[-1] == @value
      return @stack[-1]
    end
  
    # Add left tree to the stack if it exists, otherwise the right branch if it exists
    if @stack[-1]['branches']['left'].nil? == false
      @stack << tree['branches']['left']
      dfs(@stack[-1])
    elsif @stack[-1]['branches']['right'].nil? == false
      @stack << tree['branches']['right']
    elsif @stack[-1]['branches']['left'].nil? == false && @stack[-1]['branches']['right'].nil? == false
      @stack.pop
    end
    
  end
end

## Bredth first traversal
# Build a queue
# visit both branches

copy_array = [1,7,4,23,8,9,4,3,5,7,9,67,6345,324]
array = merge_sort(copy_array)
puts build_tree(array)