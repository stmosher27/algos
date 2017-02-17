require 'rspec'
require 'dynamic_programming'

describe 'Fibonacci' do
  let(:dp) { DPProblems.new() }

  it 'handles a base case' do
    expect(dp.fibonacci(1)).to equal(1)
  end

  it 'handles recursive cases' do
    expect(dp.fibonacci(6)).to equal(8)
    expect(dp.fibonacci(100)).to eq(354224848179261915075)
  end
end

describe 'Make change' do
  let(:coins) { [2, 5, 7, 10] }
  let(:dp) { DPProblems.new() }

  it 'handles the zero case' do
    expect(dp.make_change(0, coins)).to equal(0)
  end

  it 'handles a case with no solution' do
    expect(dp.make_change(1, coins).nan?).to be(true)
  end

  it 'handles recursive cases' do
    expect(dp.make_change(12, coins)).to equal(2)
    expect(dp.make_change(3, coins).nan?).to be(true)
    expect(dp.make_change(54, coins)).to equal(6)
    expect(dp.make_change(1000, coins)).to equal(100)
  end
end

describe 'Knapsack' do
  let(:dp) { DPProblems.new() }
  let (:weights1) { [23, 31, 29, 44, 53, 38, 63, 85, 89, 82 ]}
  let(:values1) { [ 92, 57, 49, 68, 60, 43, 67, 84, 87, 72 ]}
  let(:weights2) {  [12, 7, 11, 8, 9 ] }
  let(:values2) { [ 24, 13, 23, 15, 16] }

  it 'handles trivial cases' do
    expect(dp.knapsack(weights1, values1, 0)).to equal(0)
    expect(dp.knapsack(weights1, values1, 23)).to equal(92)
  end

  it 'handles recursive cases' do
    expect(dp.knapsack(weights1, values1, 165)).to equal(309)
    expect(dp.knapsack(weights2, values2, 26)).to equal(51)
  end
end

describe 'Stair climber' do
  let(:dp) { DPProblems.new() }

  it 'handles base cases' do
    expect(dp.stair_climb(1)).to eq([[1]])
    expect(dp.stair_climb(0)).to eq([[]])
  end

  it 'handles recursive cases' do
    expect(dp.stair_climb(4).sort).to eq([[1, 1, 1, 1], [1, 1, 2], [1, 2, 1], [2, 1, 1], [2, 2], [1, 3], [3, 1]].sort)
    expect(dp.stair_climb(10).length).to eq(274)
  end
end

describe 'String distance' do
  let(:dp) { DPProblems.new() }

  it 'handles trivial cases' do
    expect(dp.str_distance("", "")).to equal(0)
    expect(dp.str_distance("Math!", "Math!")).to equal(0)
  end

  it 'handles nontrivial cases' do
    expect(dp.str_distance("Dobby", "Dory")).to equal(2)
    expect(dp.str_distance("Dumbledore's Army", "Death eaters")).to equal(14)
  end
end

describe 'Maze traversal' do
  let(:maze1) { [['x', 'x', 'x', 'x'],
                 ['x', ' ', ' ', 'x'],
                 ['x', 'x', ' ', 'x']] }
  let(:maze2) { [['x', 'x', 'x', ' ', 'x', 'x', ' ', 'x'],
                 ['x', ' ', 'x', ' ', 'x', 'x', ' ', 'x'],
                 ['x', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
                 ['x', 'x', 'x', ' ', 'x', 'x', ' ', 'x'],
                 ['x', ' ', ' ', ' ', ' ', 'x', ' ', 'x'],
                 ['x', 'x', 'x', 'x', 'x', 'x', 'x', 'x']] }

  let(:dp) { DPProblems.new() }

  it 'handles start positions on the edge of the maze' do
    expect(dp.maze_escape(maze1, [2, 2])).to equal(1)
    expect(dp.maze_escape(maze2, [2, 7])).to equal(1)
  end

  it 'finds the correct solution' do
    expect(dp.maze_escape(maze1, [1, 1])).to equal(3)
  end

  it 'chooses the optimal solution among many' do
    expect(dp.maze_escape(maze2, [4, 1])).to equal(7)
    expect(dp.maze_escape(maze2, [1, 1])).to equal(6)
  end
end