#!/usr/bin/env ruby


def dayOne()
  #Collect data into two arrays; left and right
  left  = Array.new()
  right = Array.new()

  data  = File.read("data2").split

  for x in 0..data.length()-1 do
    if x.even?
      left.push(data[x].to_i)
    else
      right.push(data[x].to_i)
    end
  end

  counts = counter(right)
  scores = Array.new()
  left.each { |x| scores.push(x*counts[x])}

  total = 0
  scores.each{ |x| total = total + x}
  #output finding
  puts total
end

def counter(data)
  counts = Array.new(99999, 0)
  data.each {|x| counts[x] = counts[x]+1}
  return counts
end

dayOne()


