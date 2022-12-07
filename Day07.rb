#====init bruv====
input = File.read('input\day07.txt').split("\n").map(&:split)
parentDirs = []
dirSize={'/' => 0}
#====solve====
input.each{|x|
    case x[0]
        when 'dir' then dirSize[parentDirs*'/' + x[1]] = 0 if !dirSize.key?(parentDirs*'/' + x[1])
        when '$'   then x[2] == '..' ? parentDirs.pop : parentDirs << (parentDirs*'/' + x[2]) if x[1] == "cd"
        else parentDirs.each{|r|dirSize[r] += x[0].to_i }
    end
}
puts dirSize.values.reject{_1>100000}.sum
puts dirSize.select{|k,v| v > (30000000 - 70000000 + dirSize['/'])}.sort_by{|k,v| v}.first[1]
