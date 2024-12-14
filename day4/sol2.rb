#!/usr/bin/env ruby
# frozen_string_literal: true

def solution
  data = File.read('data').split("\n")
  row = 0
  col = 0
  seeds = []
  total = 0

  # Find all seed locations
  data.each do |line|
    line.split("").each do |char|
      # If its a seed then put its location on the stack
      seeds.push([row, col]) if char == 'A'
      col += 1
    end
    col = 0
    row += 1
  end


  seeds.each do |seed|
    total += try_all_directions(seed, data)
  end

  puts data
  puts total
end

def try_all_directions(seed, data)
  total = 0
  rows = data.length
  columns = data[0].length
  row = seed[0]
  col = seed[1]

  if row-1 >= 0 and col-1 >= 0
    top_left  = data[row-1].split("")[col-1]
  else
    return 0
  end

  if row-1 >= 0 and col+1 < columns
    top_right = data[row-1].split("")[col+1]
  else
    return 0
  end

  if row+1 < rows and col-1 >= 0
    bot_left  = data[row+1].split("")[col-1]
  else
    return 0
  end

  if row+1 < rows and col+1 < columns 
    bot_right = data[row+1].split("")[col+1]
  else
    return 0
  end

  checkStr = top_left + top_right + bot_left + bot_right
  if checkStr == "MMSS" or checkStr == "MSMS" or checkStr == "SSMM" or checkStr == "SMSM"
    total += 1
    puts "#{seed[0]} #{seed[1]}"
    puts "#{top_left}#{top_right}#{bot_left}#{bot_right}"
  end
=begin

.M.S......
..A..MSMS.
.M.S.MAA..
..A.ASMSM.
.M.S.M....
..........
S.S.S.S.S.
.A.A.A.A..
M.M.M.M.M.
..........

0123456789
.M.S......0
..G..MSMS.1
.M.S.MAG..2
..G.GSMSM.3
.M.S.M....4
..........5
S.S.S.S.S.6
.G.G.G.G..7
M.M.M.M.M.8
..........9
=end

=begin
  #M M
  # A
  #S S
  if 
  if top_left == 'M' and top_right == 'M' and bot_left == 'S' and bot_right == 'S'
    total += 1
    puts "one"
  end

  #M S
  # A
  #M S
  if top_left == 'M' and top_right == 'S' and bot_left == 'M' and bot_right == 'S'
    total += 1
    puts "two"
  end

  #S S
  # A
  #M M
  if top_left == 'S' and top_right == 'S' and bot_left == 'M' and bot_right == 'M'
    total += 1
    puts "three"
  end

  #S M
  # A
  #S M
  if top_left == 'S' and top_right == 'M' and bot_left == 'S' and bot_right == 'M'
    total += 1
    puts "four"
  end
=end

  total
end


solution
