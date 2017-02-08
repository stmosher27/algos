require_relative "static_array"

class RingBuffer
  attr_reader :length

  def initialize
    @capacity = 8
    @store = StaticArray.new(@capacity)
    @start_idx = 0
    @length = 0
  end

  # O(1)
  def [](index)
    if index < 0 || index >= @length
      raise 'index out of bounds'
    else
      @store[(@start_idx + index) % @capacity]
    end
  end

  # O(1)
  def []=(index, val)
    if @length == 0 || index >= @length
      raise 'index out of bounds'
    else
      @store[(@start_idx + index) % @capacity] = val
    end
  end

  # O(1)
  def pop
    raise "index out of bounds" if length == 0

    value = self[length - 1]
    @store[(@start_idx + @length) % @capacity] = nil
    @length -= 1

    value
  end

  # O(1) ammortized
  def push(val)
    resize! if @length == @capacity

    @length += 1
    @store[(@start_idx + @length - 1) % @capacity] = val
    nil
  end

  # O(1)
  def shift
    raise "index out of bounds" if @length == 0

    value = @store[@start_idx]
    @store[@start_idx] = nil
    @start_idx = (@start_idx + 1) % @capacity
    @length -= 1

    value
  end

  # O(1) ammortized
  def unshift(val)
    resize! if @length == @capacity

    @start_idx = (@start_idx - 1) % @capacity
    @length += 1
    @store[@start_idx] = val
  end

  protected
  attr_accessor :capacity, :start_idx, :store
  attr_writer :length

  def check_index(index)
  end

  def resize!
    new_capacity = @capacity * 2
    new_array = StaticArray.new(new_capacity)
    (0...@length).each do |i|
      new_array[i] = @store[@start_idx % @capacity]
      @start_idx += 1
    end
    @capacity = new_capacity
    @store = new_array
    @start_idx = 0
  end
end
