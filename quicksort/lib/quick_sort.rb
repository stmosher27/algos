class QuickSort
  # Quick sort has average case time complexity O(nlogn), but worst
  # case O(n**2).

  # Not in-place. Uses O(n) memory.
  def self.sort1(array)
    return array if array.length <= 1
    pivot = array.first
    left = []
    right = []
    array.slice(1..-1).each do |el|
      left << el if pivot > el
      right << el if pivot <= el
    end
    sorted_left = QuickSort.sort1(left)
    sorted_right = QuickSort.sort1(right)
    sorted_left + [pivot] + sorted_right
  end

  # In-place.
  def self.sort2!(array, start = 0, length = array.length, &prc)

  end

  def self.partition(array, start, length, &prc)

  end
end

p QuickSort.sort1([2,3,4,1,1])
