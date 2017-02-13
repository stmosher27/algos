class BSTNode
  attr_accessor :left, :right
  attr_reader :value

  def initialize(value)
    @value = value
    @right = nil
    @left = nil
  end
end

class BinarySearchTree
  def initialize
    @root = nil
  end

  def insert(value)
    if @root
      BinarySearchTree.insert!(@root, value)
    else
      @root = BSTNode.new(value)
    end
  end

  def find(value)
    BinarySearchTree.find!(@root, value)
  end

  def inorder
    BinarySearchTree.inorder!(@root)
  end

  def postorder
    BinarySearchTree.postorder!(@root)
  end

  def preorder
    BinarySearchTree.preorder!(@root)
  end

  def height
    BinarySearchTree.height!(@root)
  end

  def min
    BinarySearchTree.min(@root)
  end

  def max
    BinarySearchTree.max(@root)
  end

  def delete(value)
    @root = BinarySearchTree.delete!(@root, value)
  end

  def self.insert!(node, value)
    if !node
      return BSTNode.new(value)
    end

    if value <= node.value
      node.left = BinarySearchTree.insert!(node.left, value)
    else
      node.right = BinarySearchTree.insert!(node.right, value)
    end
    node
  end

  def self.find!(node, value)
    if !node
      return nil
    elsif node.value == value
      return node
    end

    if value < node.value
      return BinarySearchTree.find!(node.left, value)
    else
      return BinarySearchTree.find!(node.right, value)
    end
  end

  def self.preorder!(node)
    if !node
      return []
    end

    array = [node.value]
    if node.left
      array += BinarySearchTree.preorder!(node.left)
    end
    if node.right
      array += BinarySearchTree.preorder!(node.right)
    end
    array
  end

  def self.inorder!(node)
    if !node
      return []
    end

    array = []
    if node.left
      array += BinarySearchTree.inorder!(node.left)
    end

    array.push(node.value)
    
    if node.right
      array += BinarySearchTree.inorder!(node.right)
    end
    array
  end

  def self.postorder!(node)
    if !node
      return []
    end

    array = []
    if node.left
      array += BinarySearchTree.postorder!(node.left)
    end
    if node.right
      array += BinarySearchTree.postorder!(node.right)
    end
    array.push(node.value)

    array
  end

  def self.height!(node)
    if !node
      return -1
    end

    1 + [BinarySearchTree.height!(node.left), BinarySearchTree.height!(node.right)].max
  end

  def self.max(node)
    if !node
      return nil
    end
    if !node.right
      return node
    end

    BinarySearchTree.max(node.right)
  end

  def self.min(node)
    if !node
      return nil
    end
    if !node.left
      return node
    end

    BinarySearchTree.min(node.left)
  end

  def self.delete_min!(node)
    if !node
      return nil
    end
    if !node.left
      return node.right
    end

    node.left = BinarySearchTree.delete_min!(node.left)
    node
  end

  def self.delete!(node, value)
    return nil unless node

    if value < node.value
      node.left = BinarySearchTree.delete!(node.left, value)
    elsif value > node.value
      node.right = BinarySearchTree.delete!(node.right, value)
    else
      return node.left unless node.right
      return node.right unless node.left
      t = node
      node = t.right.min
      node.right = BinarySearchTree.delete_min!(t.right)
      node.left = t.left
    end

    node
  end
end
