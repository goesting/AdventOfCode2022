input = File.read('input\day01.txt').split("\n\n").map{_1.split.map(&:to_i).sum}
puts input.max,input.sort[-3..].sum
