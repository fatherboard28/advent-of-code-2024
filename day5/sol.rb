#!/usr/bin/env ruby
# frozen_string_literal: true

def solution
  raw_rules = File.read('rules2').split("\n")
  changes = File.read('changes2').split("\n")

  rules = Array.new
  raw_rules.each do |rule|
    r = rule.split("|")
    rules.push([r[0], r[1]])
  end

  good_changes = Array.new

  changes.each do |change|

    applicable_rules = Array.new

    rules.each do |x|
      if change.include? x[0] and change.include? x[1]
        applicable_rules.push(x)
      end
    end

    changePasses = 1
    applicable_rules.each do |rule|
      firstPos = -1
      secondPos = -1

      i = 0
      change.split(",").each do |x|
        firstPos = i if x == rule[0]
        secondPos = i if x == rule[1]
        i += 1
      end

      if firstPos == -1 or secondPos == -1 or firstPos < secondPos
        changePasses *= 1
      else
        changePasses *= 0
      end
    end
    good_changes.push((changePasses == 1))
  end

  puts good_changes
  sum = 0
  i = 0
  good_changes.each do |x|
    if not x
      puts changes[i]
      y = sort(changes[i].split(","), rules)
      sum += y[(y.length/2).ceil].to_i
    end
    i += 1
  end
  puts sum
end

def compare(a, b, rules, changeLine)
  firstPos = -1
  secondPos = -1

  puts "#{a} - #{b}"
  applicable_rule = rules.select {|rule| (a == rule[0] and b == rule[1]) or (a == rule[1] and b == rule[0])}[0]
  puts "#{applicable_rule[0]} | #{applicable_rule[1]}"

  (changeLine.length).times do |i|
    if applicable_rule[0].to_i == changeLine[i].to_i
      puts "a (#{i})"
      firstPos = i  
    end
    if applicable_rule[1].to_i == changeLine[i].to_i
      puts "b (#{i})"
      secondPos = i
    end
  end

  puts "#{firstPos} ^ #{secondPos}"
  puts firstPos < secondPos
  return firstPos < secondPos
end

def sort(array, rules)
  n = array.length
  return array if n <= 1

  loop do
    swapped = false

    (n-1).times do |i|
      if compare(array[i], array[i+1], rules, array)
        array[i], array[i+1] = array[i+1], array[i]
        swapped = true
      end
    end

    break if not swapped
  end

  puts array
  return array
end

solution
