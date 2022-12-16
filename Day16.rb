def getMostPressureLoss(currentState,flowrates,valvesOpen, path)
    nextState = currentState.dup
    nextValvesOpen = valvesOpen.dup
    x = -1
    if currentState['time'] == 30
        x = currentState['losses']
    elsif $stateresults[currentState.values*'-' + '=' + valvesOpen.values*'-']
        x = $stateresults[currentState.values*'-' + '=' + valvesOpen.values*'-']
    else
        nextState['time'] +=1
        valvesOpen.each{|k,v|
            nextState['losses'] += flowrates[k] if v
        } 
        $connections[currentState['currentPosition']].each{|conn|
            nextState['currentPosition'] = conn
            #print " " *currentState['time']
            #puts "#{currentState.inspect} -> #{nextState.inspect}"
            f,path = getMostPressureLoss(nextState,flowrates,valvesOpen,path + conn)
            x = [f,x].max
        }
        #open valve
        if valvesOpen[currentState['currentPosition']] == false
            nextValvesOpen[currentState['currentPosition']] = true
            nextState['currentPosition'] = currentState['currentPosition']
            #print " " *currentState['time']
            #puts "#{currentState.inspect} -> #{nextState.inspect}"
            x,path = getMostPressureLoss(nextState,flowrates,nextValvesOpen, path + 'oo')
            x = [x,currentState['losses']].max
        end
        
        
        
    end
    $stateresults[currentState.values*'-' + '=' + valvesOpen.values*'-'] = x
    [x, path + currentState['currentPosition']]
end

flowrates = {}
$connections = {}
valvesOpen = {}
$stateresults = {}

input = File.read("input/day16.txt").split("\n")
input.each{|line|
    name = line.split[1]
    flowrates[name] = line.split('=')[1].to_i
    $connections[name] = (line.split[9..]*"").split(",")
    valvesOpen[name] = false
}

puts flowrates.inspect
puts $connections.inspect
puts valvesOpen.inspect

state = {'time' => 0, 'losses' => 0, 'currentPosition' => 'AA'}

puts getMostPressureLoss(state,flowrates,valvesOpen, "")
