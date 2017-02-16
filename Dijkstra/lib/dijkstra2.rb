require_relative 'graph'
require_relative 'priority_map'

# O(|V| + |E|*log(|V|)).
def dijkstra2(source)
  locked_in_paths = {}
  possible_paths = PriorityMap.new do |data1, data2|
    data1[:cost] <=> data2[:cost]
  end
  possible_paths[source] = { cost: 0, last_edge: nil }

  until possible_paths.empty?
    vertex, data = possible_paths.extract
    locked_in_paths[vertex] = data

    update_possible_paths(vertex, locked_in_paths, possible_paths)
  end

  locked_in_paths
end

def update_possible_paths(vertex, locked_in_paths, possible_paths)
  path_to_vertex_cost = locked_in_paths[vertex][:cost]

  vertex.out_edges.each do |e|
    to_vertex = e.to_vertex

    next if locked_in_paths.has_key?(to_vertex)

    extended_path_cost = path_to_vertex_cost + e.cost
    next if possible_paths.has_key?(to_vertex) &&
            possible_paths[to_vertex][:cost] <= extended_path_cost

    possible_paths[to_vertex] = {
      cost: extended_path_cost,
      last_edge: e
    }
  end
end
