##### INPUT #####
f = File.read('Day11.txt').split("\n\n").map{|y| y.split("\n")}
f.each{|z| z.map!{|line|
    x=line.split
    if x[0] == "Starting"
        res = x[2..].map(&:to_i)
    elsif x[0] == "Operation:"
        res = [x[4].to_s,x[5]]
    elsif x[0] == "Test:"
        res = x[3].to_i
    elsif x[1] == "true:"
        res = x[5].to_i
    elsif x[1] == "false:"
        res = x[5].to_i
    elsif x[0] == "Monkey"
        res = 0
    else
        warn "you are terrible at coding #{x}"
    end
}
}
commonDivisor = f.map{|g| g[3]}.reduce :*
##### SOLVE #####
rounds = 10000 #set to 20 for part 1
1.upto(rounds){|r|
    f.map!{|monkeh|
        monkeh[0] += monkeh[1].size
        targetTrue = monkeh[4]
        targetFalse = monkeh[5]
        testDivis = monkeh[3]

        monkeh[1].each{|item|
            worry = item
            worryMulti = 0
            if monkeh[2][1] == "old"
                worryMulti = worry 
            else
                worryMulti = monkeh[2][1].to_i
            end
            worry = [worry, worryMulti].inject(monkeh[2][0]) % commonDivisor   #for part 1 , replace the modulo by /3
            if worry % testDivis == 0
                f[targetTrue][1] << worry
            else
                f[targetFalse][1] << worry
            end
        }
        monkeh[1] = []
        monkeh
    }
}
puts f.map{|m|m[0]}.sort[-2..].reduce :*
