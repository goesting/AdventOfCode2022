f = File.read('Day03.txt').split
#part 1
puts f.map{|x| x[...x.size/2].chars & x[x.size/2..].chars}.flatten.map{_1.ord - 96}.map{_1 < 0 ? _1+58 : _1}.sum

#part 2
puts f.each_slice(3).to_a.map{|x| x.map(&:chars).reduce(:&)}.flatten.map{_1.ord - 96}.map{_1 < 0 ? _1+58 : _1}.sum
