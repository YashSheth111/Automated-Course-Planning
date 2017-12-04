require 'minitest/autorun'

require 'csv'
require_relative 'graph'
require_relative 'node'
require_relative 'breath_first_search'

load 'output.rb'

describe BreathFirstSearch do
  before do
    @fHash = Hash.new
    
    CSV.foreach("curriculum.csv") do|row1|
      @fHash["#{row1[0]}"] = "#{row1[1]}"
    end
    
    len = @fHash.length
    @number = Array.new(len)

    for i in 1..len-1
      @number[i] = Node.new(@fHash.fetch("#{i}"))
    end

  end

  it 'finds a long path to a node when it needs to go deep in a previous adjacent node' do
    graph = Graph.new
    @tHash = Hash.new{|hsh,key| hsh[key] = [] }
    @cHash = Hash.new{|hsh,key| hsh[key] = [] }
    CSV.foreach("PREREQMAPPING.csv") do|row1|
      key = row1[0]
      value = row1[1]
      @tHash["#{key}"].push value
    end
    @tHash.shift
    @cHash = @tHash.to_hash
    while (!@cHash.empty?) do
      values = Array.new
      value = Array.new
      key, values = @cHash.first
      len = values.length
      for j in 0..len-1
          value[j] = values[j]    
      end
      val_len = value.length  
      counter  = 0
      if (val_len < 1)
          @cHash.shift
      else
          while(counter != val_len) do
              key1 = key.to_i
              val1 = value[counter].to_i
              graph.add_edge(@number[key1], @number[val1])
              counter +=1
          end
          @cHash.shift
      end
    end

    CSV.foreach("curriculum.csv") do|row1|
    @fHash["#{row1[0]}"] = "#{row1[1]}"
    end
 
    source = @fHash.key("root").to_i
    puts "Enter the class needs to be taken: "
    dest = gets.chomp
    destination = @fHash.key(dest).to_i

    puts "The path for taking #{dest} class: "

    path = BreathFirstSearch.new(@graph, @number[source]).path_to(@number[destination])  
  end
end