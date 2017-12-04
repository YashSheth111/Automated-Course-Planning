require 'csv'

@fHash = Hash.new
@sHash = Hash.new
@tHash = Hash.new{|hsh,key| hsh[key] = [] }

CSV.foreach("curriculum.csv") do|row1|
    @sHash["#{row1[0]}"] = "#{row1[2]}"
end

CSV.foreach("curriculum.csv") do|row1|
    @fHash["#{row1[0]}"] = "#{row1[1]}"
end
print @fHash.fetch("12")
 print @sHash.fetch(@fHash.key(@fHash.fetch("12")))
 print @sHash.fetch("2") 
CSV.foreach("PREREQMAPPING.csv") do|row2|
    key = row2[0]
    value = row2[1]
   @tHash["#{key}"].push value
end
@tHash.shift


values = Array.new
number = Array.new
key, values = @tHash.first
for i in 1..values.length
    number[i] = values[i]
    print number[i]
    print " "
end
