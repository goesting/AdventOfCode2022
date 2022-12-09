require 'matrix'
input = File.read('input\day09.txt').split("\n").map{|x|x.split}.map{|y| [y[0],y[1].to_i]}
directions = {"U" => Vector[0,1], "D" => Vector[0,-1], "L" => Vector[-1,0], "R" => Vector[1,0]}
taillocationsA = {}                   #keeps track of where the final tail has been to
taillocationsB = {}
head = tail = Vector[0,0]             #init head, and tail for part A
tails = Array.new(9).map{Vector[0,0]} #multi tails for part B

input.each{|line|
    line[1].times{|i|
        head += directions[line[0]]
        ###### A ######
        diff = head - tail
        tail = head + diff.map{|x| x.abs==diff.map(&:abs).max ? -1*(x <=> 0) : 0}
        taillocationsA[tail] = true
        ###### B ######
        tails.map!.with_index{|x,j|
            leadKnot = j==0 ? head : tails[j-1]
            diff = leadKnot - x
            nextloc = diff.map{|y| y.abs==diff.max_by{_1.abs}.abs ? -1*(y <=> 0) : 0}
            leadKnot+nextloc
        }
        taillocationsB[tails[-1]] = true
    }
}
puts taillocationsA.size
puts taillocationsB.size
