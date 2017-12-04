#!/usr/bin/ruby
$:.unshift( "../lib" )
require "ruby-graphviz"
require 'csv'

@fHash = Hash.new
@sHash = Hash.new
@tHash = Hash.new{|hsh,key| hsh[key] = [] }
@cHash = Hash.new{|hsh,key| hsh[key] = [] }

CSV.foreach("curriculum.csv") do|row1|
    @sHash["#{row1[0]}"] = "#{row1[2]}"
end

CSV.foreach("curriculum.csv") do|row1|
    @fHash["#{row1[0]}"] = "#{row1[1]}"
end

graph = nil
if ARGV[0]
  graph = GraphViz::new(:G, :type =>digraph )
else
  graph = GraphViz::new( "G" )
end

len = @fHash.length
number = Array.new(len)

for i in 1..len-1

    number[i] = graph.add_nodes(@fHash.fetch("#{i}"))
end

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
            graph.add_edges(number[key1], number[val1])
            counter +=1
        end
        @cHash.shift
    end
end
graph.output( :png => "map.png" )