###################
### Read Inputs ###
###################
input = File.read('input/day05.txt').split("\n")
allStacks = input.select{_1.include?('[')}.map{|x| (x.chars.select.with_index{|x,i| i%4==1})}.transpose.map(&:reverse).map{|x| x.reject{_1 ==' '}}
movements = input.select{_1.include?('move')}.map{_1.delete("^[0-9 ]").split.map(&:to_i)}
solvingPart = 2

####################
### Solve Part 1 ###
####################
if solvingPart == 1
    movements.each{|m|
        amount,origin,destination = m
        amount.times{allStacks[destination-1].push(allStacks[origin-1].pop)}
    }
    puts allStacks.map{_1.pop}*''
####################
### Solve Part 2 ###
####################
else
temp=[]
movements.each{|m|
    amount,origin,destination = m
    amount.times{temp.push(allStacks[origin-1].pop)}
    amount.times{allStacks[destination-1].push(temp.pop)}
}
puts allStacks.map{_1.pop}*''

end
