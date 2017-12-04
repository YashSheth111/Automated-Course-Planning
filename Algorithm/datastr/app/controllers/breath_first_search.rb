require_relative 'node'
class BreathFirstSearch
  def initialize(graph, source_node)
    @graph = graph
    @source_node = source_node
    @visited = []
    @edge_to = {}

    bfs(source_node)
  end

  # After the depth-first search is done we can find
  # any vertice connected to "node" in constant time [O(1)]
  # and find a path to this node in linear time [O(n)].
  def path_to(node)
    return unless has_path_to?(node)
    path = []

    while(node != @node) do
      path.unshift(node) # unshift adds the node to the beginning of the array
      node = @edge_to[node]
    end
    path.unshift(node)
    len = path.length
    for i in 1..len-1
        print path[i].to_s + " "
      end
  end

  # def path_to(node)
  #   return unless has_path_to?(node)
  #   path = []
  #   @fHash = Hash.new
  #   @sHash = Hash.new
  #   CSV.foreach("curriculum.csv") do|row1|
  #     @sHash["#{row1[0]}"] = "#{row1[2]}"
  #   end
    
  #   CSV.foreach("curriculum.csv") do|row1|
  #     @fHash["#{row1[0]}"] = "#{row1[1]}"
  #   end
  #   while(node != @node) do
  #     path.unshift(node) # unshift adds the node to the beginning of the array
  #     node = @edge_to[node]
  #   end
  #   path.unshift(node)
  #   len = path.length
  #   for i in 1..len-1
  #     print @sHash.fetch(@fHash.key("#{path[i]}")) + "  "
  #   end
  # end
  
  private
  def bfs(node)
  
    queue = []
    queue << node
    @visited << node

    # Second step: Repeat until the queue is empty:
    # - Remove the least recently added node n
    # - add each of n's unvisited adjacents to the queue and mark them as visited
    while queue.any?
      current_node = queue.shift # remove first element
      current_node.adjacents.each do |adjacent_node|
        next if @visited.include?(adjacent_node)
        queue << adjacent_node
        @visited << adjacent_node
       
        @edge_to[adjacent_node] = current_node
      end
    end
  end

  def has_path_to?(node)
    @visited.include?(node)
  end


end