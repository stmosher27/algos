class DPProblems
  attr_accessor :fibonacci_cache, :dist_cache, :maze_cache

  def initialize
    @fibonacci_cache = {1 => 1, 2 => 1}
    @dist_cache = Hash.new { |hash, key| hash[key] = {} }
    @maze_cache = Hash.new { |hash, key| hash[key] = {} }
  end

  # Takes in a positive integer n and returns the nth Fibonacci number
  # Should run in O(n) time
  def fibonacci(n)
    ans = fibonacci_helper(n)
    @fibonacci_cache = {1 => 1, 2 => 1}
    ans
  end

  # We want to start with a fresh cache every time, for the purposes of testing.  In real life, you may want to
  # devise a way to keep this cache around to reference later.  We'll use this pattern throughout the solution set,
  # at least for some bottom-up implementations.
  def fibonacci_helper(n)
    return @fibonacci_cache[n] if @fibonacci_cache[n]
    next_fib = fibonacci_helper(n-1) + fibonacci_helper(n-2)
    @fibonacci_cache[n] = next_fib
  end

  # Make Change: write a function that takes in an amount and a set of coins.  Return the minimum number of coins
  # needed to make change for the given amount.  You may assume you have an unlimited supply of each type of coin.
  # If it's not possible to make change for a given amount, return nil.  You may assume that the coin array is sorted
  # and in ascending order.

  # Bottom-up implementation, with the variation that we're passing the cache through as we go rather than
  # holding it as an instance variable.
  def make_change(amt, coins, coin_cache = {0 => 0})
    return coin_cache[amt] if coin_cache[amt]
    return 0.0/0.0 if amt < coins[0]

    min_change = amt
    way_found = false
    idx = 0
    while idx < coins.length && coins[idx] <= amt
      num_change = 1 + make_change(amt - coins[idx], coins, coin_cache)
      if num_change.is_a?(Integer)
        way_found = true
        min_change = num_change if num_change < min_change
      end
      idx += 1
    end

    if way_found
      coin_cache[amt] = min_change
    else
      coin_cache[amt] = 0.0/0.0
    end
  end

  # Knapsack Problem: write a function that takes in an array of weights, an array of values, and a weight capacity
  # and returns the maximum value possible given the weight constraint.  For example: if weights = [1, 2, 3],
  # values = [10, 4, 8], and capacity = 3, your function should return 10 + 4 = 14, as the best possible set of items
  # to include are items 0 and 1, whose values are 10 and 4 respectively.  Duplicates are not allowed -- that is, you
  # can only include a particular item once.

  # Top down implementation
  def knapsack(weights, values, capacity)
    return 0 if capacity == 0 || weights.length == 0
    solution_table = knapsack_table(weights, values, capacity)
    solution_table[capacity][weights.length - 1]
  end

  # Helper method for top-down implementation
  def knapsack_table(weights, values, capacity)
    solution_table = []
    (0..capacity).each do |i|
      solution_table[i] = []
      (0..weights.length - 1).each do |j|
        if i == 0
          solution_table[i][j] = 0
        elsif j == 0
          solution_table[i][j] = weights[0] > i ? 0 : values[0]
        else
          option1 = solution_table[i][j - 1]
          option2 = i < weights[j] ? 0 : solution_table[i - weights[j]][j - 1] + values[j]
          optimum = [option1, option2].max
          solution_table[i][j] = optimum
        end
      end
    end

    solution_table
  end

  # Stair Climber: a frog climbs a set of stairs.  It can jump 1 step, 2 steps, or 3 steps at a time.
  # Write a function that returns all the possible ways the frog can get from the bottom step to step n.
  # For example, with 3 steps, your function should return [[1, 1, 1], [1, 2], [2, 1], [3]].
  # NB: this is similar to, but not the same as, make_change.  Try implementing this using the opposite
  # DP technique that you used in make_change -- bottom up if you used top down and vice versa.

  # Top-down implementation, done without a helper function.  You can delegate the work to a helper
  # function too, to make your code more modular.
  def stair_climb(n)
    ways_collection = [[[]], [[1]], [[1, 1], [2]]]

    return ways_collection[n] if n < 3

    (3..n).each do |i|
      new_way_set = []
      (1..3).each do |first_step|
        ways_collection[i - first_step].each do |way|
          new_way = [first_step]
          way.each do |step|
            new_way << step
          end
          new_way_set << new_way
        end
      end
      ways_collection << new_way_set
    end

    ways_collection.last
  end

  # String Distance: given two strings, str1 and str2, calculate the minimum number of operations to change str1 into
  # str2.  Allowed operations are deleting a character ("abc" -> "ac", e.g.), inserting a character ("abc" -> "abac", e.g.),
  # and changing a single character into another ("abc" -> "abz", e.g.).

  # Bottom up implementation
  def str_distance(str1, str2)
    ans = str_distance_helper(str1, str2)
    @dist_cache = Hash.new { |hash, key| hash[key] = {} }
    ans
  end

  def str_distance_helper(str1, str2)
    return @dist_cache[str1][str2] if @dist_cache[str1][str2]
    if str1 == str2
      @dist_cache[str1][str2] = 0
      return 0
    end

    if str1.nil?
      return str2.length
    elsif str2.nil?
      return str1.length
    end

    len1 = str1.length
    len2 = str2.length
    if str1[0] == str2[0]
      dist = str_distance_helper(str1[1..len1], str2[1..len2])
      @dist_cache[str1][str2] = dist
      return dist
    else
      poss1 = 1 + str_distance_helper(str1[1..len1], str2[1..len2])
      poss2 = 1 + str_distance_helper(str1, str2[1..len2])
      poss3 = 1 + str_distance_helper(str1[1..len1], str2)
      dist = [poss1, poss2, poss3].min
      @dist_cache[str1][str2] = dist
      dist
    end
  end

  # Maze Traversal: write a function that takes in a maze (represented as a 2D matrix) and a starting
  # position (represented as a 2-dimensional array) and returns the minimum number of steps needed to reach the edge of the maze (including the start).
  # Empty spots in the maze are represented with ' ', walls with 'x'. For example, if the maze input is:
  #            [['x', 'x', 'x', 'x'],
  #             ['x', ' ', ' ', 'x'],
  #             ['x', 'x', ' ', 'x']]
  # and the start is [1, 1], then the shortest escape route is [[1, 1], [1, 2], [2, 2]] and thus your function should return 3.

  # Bottom up solution
  def maze_escape(maze, start)
    ans = maze_escape_helper(maze, start)
    @maze_cache = Hash.new { |hash, key| hash[key] = {} }
    ans
  end

  def maze_escape_helper(maze, start)
    return @maze_cache[start[0]][start[1]] if @maze_cache[start[0]][start[1]]
    # base case
    if (start[0] == 0 || start[1] == 0) || (start[0] == maze.length - 1 || start[1] == maze[0].length - 1)
      @maze_cache[start[0]][start[1]] = 1
      return 1
    end

    # find all possible places to go
    x = start[0]
    y = start[1]
    adj_spaces = [[x + 1, y], [x - 1, y], [x, y + 1], [x, y - 1]]
    possible_moves = []
    adj_spaces.each do |space|
      if maze[space[0]][space[1]] == ' '
        possible_moves << space
      end
    end

    way_found = false
    best = maze.length*maze[0].length

    possible_moves.each do |move|
      temp_maze = make_temp_maze(maze, start)
      possible_path = maze_escape_helper(temp_maze, move)
      if possible_path.is_a?(Fixnum) && possible_path < best
        way_found = true
        best = possible_path
      end
    end

    if way_found
      @maze_cache[start[0]][start[1]] = best + 1
      return best + 1
    else
      @maze_cache[start[0]][start[1]] = 0.0/0.0
      return 0.0/0.0
    end
  end

  def make_temp_maze(maze, filled_pos)
    temp_maze = []
    maze.each_with_index do |row, i|
      temp_maze << []
      maze[i].each do |el|
        temp_maze[i] << el
      end
    end

    temp_maze[filled_pos[0]][filled_pos[1]] = 'x'
    temp_maze
  end
end