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
      seeds.push([row, col]) if char == 'X'
      col += 1
    end
    col = 0
    row += 1
  end

  seeds.each do |seed|
    puts "#{seed[0]} #{seed[1]}"
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

  # Down
  if (row + 3 < rows) && try_one_direction(1, 0, [row, col], data)
    total += 1 
    #puts "down"
    #puts seed
  end
  # Up
  if (row - 3 >= 0) && try_one_direction(-1, 0, [row, col],  data)
    total += 1 
    #puts "up"
    #puts seed
  end
  # Right
  if (col + 3 < columns) && try_one_direction(0, 1, [row, col], data)
    total += 1 
    #puts "right"
    #puts seed
  end
  # Left
  if (col - 3 >= 0) && try_one_direction(0, -1, [row, col], data)
    total += 1 
    #puts "left"
    #puts seed
  end
  # Up Right
  if (row - 3 >= 0) && (col + 3 < columns) && try_one_direction(-1, 1, [row, col], data)
    total += 1
    #puts "up right"
    #puts seed
  end
  # Up left
  if (row - 3 >= 0) && (col - 3 >= 0) 
    puts "made it"
    if try_one_direction(-1, -1, [row, col], data)
      total += 1
      puts "up left"
      puts seed
    end
  end
  # Down Right
  if (row + 3 < rows) && (col + 3 < columns) && try_one_direction(1, 1, [row, col], data)
    total += 1
    #puts "down right"
    #puts seed
  end
  # Down Left
  if (row + 3 < rows) && (col - 3 >= 0) && try_one_direction(1, -1, [row, col], data)
    total += 1
    #puts "down left"
    #puts seed
  end

  total
end

#def try_one_direction(positions, data)
  #try_letter(positions[0], 'M', data) and try_letter(positions[1], 'A', data) and try_letter(positions[2], 'S', data)
#end

def try_one_direction(row_offset, col_offset, seed, data)
  try_letter([seed[0]+1*row_offset, seed[1]+1*col_offset], 'M', data) and try_letter([seed[0]+2*row_offset, seed[1]+2*col_offset], 'A', data) and try_letter([seed[0]+3*row_offset, seed[1]+3*col_offset], 'S', data)
end

def try_letter(pos, letter, data)
  data[pos[0]].split("")[pos[1]] == letter
end

solution
