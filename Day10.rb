f = File.read('Day10.txt').split("\n").map{|x| x=="noop" ? "noop 0" : x}.map{_1.split[1].to_i}
xreg =[]
x=1
f.each{|v|
    xreg << x
    xreg << x if v != 0
    x+=v
}
puts xreg.map.with_index{|k,i| k*i}.select.with_index{|l,j| (j+1)%40 == 20}.sum
puts xreg.map.with_index{|x,i| (i%40 - x).abs < 2 ? '#' : '.' }.each_slice(40).to_a.map{_1*''}
