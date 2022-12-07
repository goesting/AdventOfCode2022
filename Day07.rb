input = File.read('input\day07.txt').split("\n").map(&:split)
puts input.map{_1[0].to_i}.sum
parentDirs = []
dirSize={'/' => 0}
input.each{|x|
    #warn "x is currently #{x.inspect}"
if x[0] == 'dir'
    dirSize[x[1]] = 0 if !dirSize.key?(x[1])
elsif x[0] == '$'
    if x[1] == "cd"
        if x[2] == '..'
            #warn parentDirs.inspect
            parentDirs.pop
        else
            parentDirs << x[2]
        end
    end
else
    parentDirs.each{|r|dirSize[r] += x[0].to_i }
end
}
puts dirSize.values.reject{_1>100000}.sum
