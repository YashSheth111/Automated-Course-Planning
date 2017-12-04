class Graph

  def add_edge(a,b)
    a.adjacents << b
    b.adjacents << a
  end
end