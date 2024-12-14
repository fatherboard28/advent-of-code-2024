#!/usr/bin/env ruby

def main
  data = readDataToArray2('data', :parseLine)
  puts data
  total = 0
  for i in (0..data.length - 2).step(2) do
    total += data[i].to_i * data[i + 1].to_i
  end
  puts total
end

def readDataToArray2(fileName, _method)
  buffer = File.read(fileName).split('')
  nums = []

  model = 'mul(X,X)'
  dos = 'do()'
  dont = "don't()"
  curNum = ''
  firstNum = ''
  pos = 0
  checkForNums = false
  doMul = true
  checkForDont = false

  buffer.each do |char|
    if doMul
      if checkForDont
        puts 'checkfordont'
        if pos == 6 and char == ')'
          pos = 0
          checkForDont = false
          doMul = false
        elsif char == dont[pos]
          pos += 1
        else
          pos = 0
          checkForDont = false
        end
      elsif char == 'd' and pos = 0
        checkForDont = true
        pos = 1
      elsif char == model[pos]
        puts " FIRST\n"
        pos += 1
      elsif checkForNums
        if isNum(char) and curNum.length <= 3
          curNum += char
        else
          case char
          when ')'
            nums.push(firstNum)
            nums.push(curNum)
            firstNum = ''
            curNum = ''
            pos = 0
            checkForNums = false
          when ','
            firstNum = curNum
            curNum = ''
            pos += 2
            checkForNums = false
          else
            pos = 0
            curNum = ''
            firstNum = ''
          end
        end
      elsif model[pos] == 'X'
        puts " THIRD\n"
        if isNum(char)
          curNum = char
          checkForNums = true
        else
          pos = 0
        end
      else
        puts " FORTH\n"
        pos = 0
      end
    elsif pos == 3 and char == ')'
      # do mul is false; look for a do()
      pos = 0
      doMul = true
    elsif char == dos[pos]
      pos += 1
    else
      pos = 0
    end
    puts char
  end

  nums
end

def isNum(char)
  Integer(char, exception: false)
end

main
