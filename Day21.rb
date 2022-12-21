def getValue(s)
    x=-1
    if $returnToMonke[s].instance_of? Fixnum
        x = $returnToMonke[s]
    else
        a,oper,b = $returnToMonke[s].split
        a = getValue(a)
        b = getValue(b)
        x = [a,b].reduce(oper.to_sym)
        $returnToMonke[s] = x
    end
    x
end
t = Process.clock_gettime(Process::CLOCK_MONOTONIC)
input = File.read('Day21.txt').split("\n")
$returnToMonke = {}
sub1 = sub2 = ""
input.each{|line|
    name, equation = line.split(': ')
    $returnToMonke[name] = equation.to_i.to_s == equation ? equation.to_i : equation
    if name == "root"
        sub1,_,sub2 = equation.split
    end
}
temp = $returnToMonke.dup
puts "Time taken for input = #{Process.clock_gettime(Process::CLOCK_MONOTONIC) - t}"
#part 1
t = Process.clock_gettime(Process::CLOCK_MONOTONIC)
puts "Result of part 1 = #{getValue('root')}"
puts "Time taken for part 1 = #{Process.clock_gettime(Process::CLOCK_MONOTONIC) - t}"
#part 2
t = Process.clock_gettime(Process::CLOCK_MONOTONIC)
humn = 1
while $returnToMonke[sub1] != $returnToMonke[sub2] do
    humn += ($returnToMonke[sub1] - $returnToMonke[sub2])/100+1
    $returnToMonke = temp.dup
    $returnToMonke['humn'] = humn
    getValue('root') 
end
puts "Result of part 2 = #{humn}"
puts "Time taken for part 2 = #{Process.clock_gettime(Process::CLOCK_MONOTONIC) - t}"

##
#Time taken for input = 0.004235500000504544
#Result of part 1 = 104272990112064
#Time taken for part 1 = 0.0061128000015742145
#Result of part 2 = 3220993874133
#Time taken for part 2 = 0.3178234999995766
##
