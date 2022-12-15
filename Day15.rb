def Manhat(x1,y1,x2,y2)
    #puts "#{x1},#{y1},#{x2},#{y2},"
    (x2-x1).abs + (y2-y1).abs
end
starting = Process.clock_gettime(Process::CLOCK_MONOTONIC)
lineToCheck = 10
input = File.read('input\day15.txt').split("\n")
sensors = input.map{_1.split(':')[0].scan(/-?\d+/).map(&:to_i)}
beacons = input.map{_1.split(':')[1].scan(/-?\d+/).map(&:to_i)}
puts sensors.inspect
puts beacons.inspect
distanc = sensors.zip(beacons).map{|x| Manhat(x[0][0],x[0][1],x[1][0],x[1][1])}
puts distanc.inspect
coveredSpots = 0
sensors.each.with_index{|s,i|
    distanceToLine = (lineToCheck - s[1]).abs
    distanceToBeacon = distanc[i]
    f = (distanceToBeacon - distanceToLine)*2
    thisSensorCoversThisManySpaces =  f < 0 ? 0 : f+1
    coveredSpots+=thisSensorCoversThisManySpaces
    puts "Sensor #{s.inspect} with length #{distanc[i]}  is #{distanceToLine} away and covers #{thisSensorCoversThisManySpaces} spaces of line 10"
}
puts " covered spots with overlap = #{coveredSpots}"
# now we need to remove all the double entries
sensors.each.with_index{|s,i|
    distanceToLineS = (lineToCheck - s[1]).abs
    coverageOfS = [(distanc[i] - distanceToLineS)*2+1,0].max
    sensors.each_with_index{|r,j|
        if j<=i
            #do nothing
        else
        distanceToLineR = (lineToCheck - r[1]).abs
        coverageOfR = [(distanc[j] - distanceToLineR)*2+1,0].max
        horizontalSpread = (r[0] - r[1]).abs
        overlap = [[(coverageOfR+coverageOfS)/2 - horizontalSpread,0].max,coverageOfR,coverageOfS].min
        overlap = 0 if coverageOfR == 0 or coverageOfS == 0
        #puts "O #{s.inspect} with #{r.inspect}, distance to line = #{distanceToLineS} range #{distanc[i]}, #{distanceToLineR} range #{distanc[j]}, coverage of line each = #{coverageOfR},#{coverageOfS}. REMOVING #{overlap}"
        coveredSpots -= overlap if overlap > 0
        end
    }
}
puts coveredSpots

=begin
starting = Process.clock_gettime(Process::CLOCK_MONOTONIC)
input = File.read('input\day15.txt').split("\n")
sensors = input.map{_1.split(':')[0].scan(/-?\d+/).map(&:to_i)}
beacons = input.map{_1.split(':')[1].scan(/-?\d+/).map(&:to_i)}
distanc = sensors.zip(beacons).map{|x| Manhat(x[0][0],x[0][1],x[1][0],x[1][0])}
puts distanc.inspect

linePart1 = lineToCheck
minX,maxX = (sensors.map{_1[0]}.minmax + beacons.map{_1[0]}.minmax).minmax 
minY,maxY = (sensors.map{_1[1]}.minmax + beacons.map{_1[1]}.minmax).minmax 

puts " Range of x from #{minX} to #{maxX}, y from #{minY} to #{maxY}"
part1Count = part1Uncount = 0
puts maxX*2 - minX*2
(minX*2).upto(maxX*2){|x|
    y = linePart1
    covered = false
    sensors.each.with_index{|s,i|
        
        ourDist = Manhat(x,y,s[0],s[1])
        theirDist = distanc[i]
        covered = true if ourDist < theirDist
        puts "Testing point #{x},#{y} against sensor #{s[0]},#{s[1]}. best distance = #{distanc[i]}. This distance = #{ourDist}"
    }
    part1Count+=1 if covered
    part1Uncount +=1 if !covered

}
puts part1Count, part1Uncount

#5479276 too high
 5602418
=end
