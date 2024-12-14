#!/usr/bin/env ruby
# frozen_string_literal: true

def solution
  raw_rules = File.read('rules').split("\n")
  changes = File.read('changes').split("\n")

  rules = Array.new
  raw_rules.each do |rule|
    r = rule.split("|")
    rules.push([r[0], r[1]])
  end

  good_changes = Array.new

  changes.each do |change|

    applicable_rules = Array.new
    change.split("").each do |x|
      applicable_rules.push(rules.select {|rule| rule.include? x})
    end

    changePasses = 1
    applicable_rules.each do |rule|
      firstPos = -1
      secondPos = -1
      for i in 0..change.length-1 do
        firstPos = i if change[i] == rule[0]
        secondPos = i if change[i] == rule[1]
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
end

solution
