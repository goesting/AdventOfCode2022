input = File.read('input\day08.txt').split("\n").map{|x|x.chars.map(&:to_i)}
##########
# Part 1 #
##########
visible = Array.new(input.size).map{Array.new(input[0].size,false)}
#=horizontal=
input.each.with_index{|x,i| x.each.with_index{|y,j|
    visible[i][j] = true if x.first(j).all?{_1<y} || x.last(x.size-j-1).all?{_1<y}}}
#=vertical=
visible = visible.transpose
input.transpose.each.with_index{|x,i| x.each.with_index{|y,j| 
    visible[i][j] = true if x.first(j).all?{_1<y} || x.last(x.size-j-1).all?{_1<y}}}
puts visible.map{_1.count(true)}.sum

##########
# Part 2 #
##########
scores = Array.new(input.size).map{Array.new(input[0].size,0)}
#=horizontal=
input.each.with_index{|x,i| x.each.with_index{|y,j|
    scores[i][j] = ((x.first(j).reverse.index{|x| x>= y}||j-1)+1) * ((x.last(x.size-j-1).index{|x| x>= y}||x.size-j-2)+1)}}
#=vertical=
scores = scores.transpose
input.transpose.each.with_index{|x,i| x.each.with_index{|y,j|
    scores[i][j] *= ((x.first(j).reverse.index{|x| x>= y}||j-1)+1) * ((x.last(x.size-j-1).index{|x| x>= y}||x.size-j-2)+1)}}
puts scores.map(&:max).max
