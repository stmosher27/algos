require_relative 'graph'

# Implementing topological sort using both Khan's and Tarian's algorithms

def topological_sort(vertices)
  in_edges = {}
  arr = []
  sorted = []

  vertices.each do |v|
    in_edges[v] = v.in_edges.length
    if v.in_edges.length == 0
      arr.push(v)
    end
  end

  until arr.length == 0
    v = arr.shift
    sorted.push(v)
    v.out_edges.each do |e|
      to = e.to_vertex

      in_edges[to] -= 1
      if in_edges[to] == 0
        arr.push(to)
      end
    end
  end
  sorted
end
