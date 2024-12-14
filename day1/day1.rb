#/usr/bin/env ruby


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

  #sort arrays
  left  = left.sort
  right = right.sort

  #find distances
  dists = Array.new()
  for x in 0..left.length()-1 do
    dists.push(( left[x] - right[x] ).abs)
  end

  #calculate totals
  total = 0
  dists.each do |x|
    total = total + x
  end

  #output finding
  puts total
end

dayOne()


