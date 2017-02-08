require_relative "static_array"

class DynamicArray
  attr_reader :length

  def initialize
    @capacity = 8
    @store = StaticArray.new(@capacity)
    @length = 0
  end

  # O(1)
  def [](index)
    if @length == 0 || index >= @length
      raise 'index out of bounds'
    else
      @store[index]
    end
  end

  # O(1)
  def []=(index, value)
    if index >= @length
      raise 'index out of bounds'
    end
    @store[index] = value
  end

  # O(1)
  def pop
    raise 'index out of bounds' if @length == 0
    @length -= 1
  end

  # O(1) ammortized; O(n) worst case. Variable because of the possible
  # resize.
  def push(val)
    resize! if @length == @capacity
    @store[@length] = val
    @length += 1
  end

  # O(n): has to shift over all the elements.
  def shift
    raise 'index out of bounds' if @length == 0
    newArray = StaticArray.new(@capacity)
    (1...@length).each do |idx|
      newArray[idx-1] = @store[idx]
    end
    @store = newArray
    @length -= 1
  end

  # O(n): has to shift over all the elements.
  def unshift(val)
    resize! if @length == @capacity
    newArray = StaticArray.new(@capacity)
    newArray[0] = val
    (0...@length).each do |i|
      newArray[i+1] = @store[i]
    end
    @store = newArray
    @length += 1
  end

  protected
  attr_accessor :capacity, :store
  attr_writer :length

  def check_index(index)
  end

  # O(n): has to copy over all the elements to the new store.
  def resize!
    @capacity *= 2
    newArray = StaticArray.new(@capacity)
    (0...@length).each do |i|
      newArray[i] = @store[i]
    end
    @store = newArray
  end
end
