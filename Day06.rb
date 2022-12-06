input = File.read('input/day06.txt')
puts input.chars.each_cons(4).map.with_index{|x,i| [x,i]}.find{|f| f[0].uniq.size == f[0].size}[1] + 4
puts input.chars.each_cons(14).map.with_index{|x,i| [x,i]}.find{|f| f[0].uniq.size == f[0].size}[1] + 14
