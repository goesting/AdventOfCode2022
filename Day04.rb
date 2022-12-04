f = File.read('Day04.txt').tr('-',',').split.map{_1.split(',').map(&:to_i)}

#part 1
puts f.select{|x| ((x[0]<=x[2] && x[1] >= x[3]) || (x[0]>=x[2] && x[1] <= x[3]))}.count

#part2
puts f.select{|x| ([*x[0]..x[1]] & [*x[2]..x[3]]).count > 0}.count
