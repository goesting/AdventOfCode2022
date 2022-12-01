#inputs is just the entire txt file

#part 1
puts input.split("\n\n").map{_1.split.map(&:to_i).sum}.max

#part 2
puts input.split("\n\n").map{_1.split.map(&:to_i).sum}.sort[-3..].sum
