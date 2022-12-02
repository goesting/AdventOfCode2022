part = 2
input = File.read('C:\Users\tpz1ppc\AoC22\input\day02.txt')

#### part1 ###
if part == 1
    input = input.tr('ABCXYZ','123123').split("\n").map{_1.split.map(&:to_i)}    
    puts input.map{|x| 
        x1,x2=x
        x2+=6 if (x2-x1)%3 == 1
        x2=x2+3 if x2==x1
        x2
    }.sum
    
#### part2 ###
elsif part == 2
    input = input.tr('ABC','123').split("\n").map{_1.split}
    puts input.map{|x|
        x1,x2 = x
        x1 = x1.to_i
        x2 = (x1-2)%3+1 if x2 == 'X'  #lose  
        x2 = x1 if x2 == 'Y'          #draw
        x2 = x1%3+1 if x2 == 'Z'      #win
        x2+= 6 if (x2-x1)%3 == 1
        x2 = x2+3 if x2 == x1
        x2
    }.sum
end
