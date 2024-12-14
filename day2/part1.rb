#!/usr/bin/env ruby

def main()
  data = readDataToArray2("data", :parseLine)
  puts data
end

def isValid(data)
  y = Array.new()
  for i in 0..data.length-2 do
    y.push(data[i].to_i - data[i+1].to_i)
  end

  if (y.all?  {|x| (x > 0) and ([ 1, 2, 3].include?(x)) }) or 
      (y.all? {|x| (x < 0) and ([-3,-2,-1].include?(x)) })
    return true
  else
    return false
  end

end


def readDataToArray2(fileName, method)
  data = File.read(fileName).split("\n")
  returnData = 0
  array = Array.new()

  for x in 0..data.length-1 do
    dataLine = data[x].split
    line = isValid(dataLine)
    array.push(line)
    if line
      returnData += 1
    else
      for x in 0..dataLine.length-1 do
        tmp = dataLine.dup
        tmp.delete_at(x)
        if isValid(tmp)
          returnData += 1
          break
        end
      end
    end
  end

  return returnData
  #return array
end

main()
