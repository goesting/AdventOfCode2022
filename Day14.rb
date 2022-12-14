#### Read input and set variables ####
starting = Process.clock_gettime(Process::CLOCK_MONOTONIC)
input = File.read('input\day14.txt').split("\n").map{|line| line.split(' -> ').map{|coord| coord.split(',').map(&:to_i)}}.map!{|line| line[..-2].zip(line[1..])}

dropH,dropW = [0,500]
minH,maxH = input.map{|section| section.map{|l| l.map{|point| point[1]}}}.flatten.minmax
minH = [minH,dropH].min
maxW,minW = input.map{|section| section.map{|l| l.map{|point| point[0]}}}.flatten.minmax

 #Adjustements to help with part 2
maxH = maxH + 2
maxW = [maxW,500+maxH].max+2 #check if triangle from top spreads out further
minW = [minW,500-maxH].min-2

caveFull = Array.new((maxH-minH)).map{Array.new((maxW-minW)+1, '.')}
caveFull << Array.new((maxW-minW)+1, '#') #set cave to all air except for bottom line all floor

 #Fill in cave walls
input.each{|section| section.each{|coords|
    x1,y1 = coords[0]
    x2,y2 = coords[1]
    [x1,x2].min.upto([x1,x2].max){|x|
        x = x - minW #all x values are offset against the minimum, which is 0-index in the cavearray
        [y1,y2].min.upto([y1,y2].max){|y|
            y = y - minH #same same but different
            caveFull[y][x] = '#'
        }
    }
}}
## Get timing results for input prep ##
ending = Process.clock_gettime(Process::CLOCK_MONOTONIC)
puts "Time to read input = #{(ending - starting).real.round(5)} seconds"
starting = ending
########## part 1 #############
cave = caveFull[..-3].map(&:dup) #last 2 lines are only for part 2, copy ByValue
maxH -=2
sandOutside = false
sandInside = 0
while !sandOutside do #drop more sand untill one of them falls off
    sandY = dropH - minH    #convert coords of sand spawn to our cave coords
    sandX = dropW - minW    # probably not needed for Y
    sandFalling = true
    while sandFalling do #loop to drop a single sand untill it settles or falls off
        if sandY+1 > maxH #Check right below you first
            sandOutside = true
            sandFalling = false
        else
            case cave[sandY+1][sandX] 
            when '.'
                sandY += 1
            else
                if sandX-1 < 0
                    sandOutside = true
                    sandFalling = false
                else
                    case cave[sandY+1][sandX-1] #Then check down and to the left
                    when '.'
                        sandY+=1
                        sandX-=1
                    else
                        if sandX+1 > maxW-minW+1
                            sandOutside = true
                            sandFalling = false
                        else
                            case cave[sandY+1][sandX+1]#Then check down and to the right
                            when '.'
                                sandY += 1
                                sandX += 1
                            else
                                sandFalling = false
                                cave[sandY][sandX] = 'o'
                            end
                        end
                    end
                end
            end
        end
    end
    #Someone please clean up my nests
    sandInside +=1 if sandOutside == false
end
## Timing results for part 1 ##
puts "Part 1 result: Amount of sand that has landed = #{sandInside}"
ending = Process.clock_gettime(Process::CLOCK_MONOTONIC)
puts "Time for part 1 = #{(ending-starting).real.round(5)} seconds"
starting = ending
###### part 2 ###########
maxH+=2
cave = caveFull
sandInside = 0
while cave[dropH - minH][dropW - minW] == '.' do #drop more sand if origin is air
    sandY = dropH - minH
    sandX = dropW - minW
    sandFalling = true
    while sandFalling do
        case cave[sandY+1][sandX] #drop down?
        when '.'
            sandY += 1
        else
            case cave[sandY+1][sandX-1] #down and left?
            when '.'
                sandY+=1
                sandX-=1
            else
                case cave[sandY+1][sandX+1] #down and right?
                when '.'
                    sandY += 1
                    sandX += 1
                else # else cannot fall, stay there
                    sandFalling = false
                    cave[sandY][sandX] = 'o'
                end
            end
        end
    end
    sandInside +=1
end
puts "Part 2: Amount of sand that has landed = #{sandInside}"
## Timing for part 2 ##
ending = Process.clock_gettime(Process::CLOCK_MONOTONIC)
puts "Time for part 2 = #{(ending - starting).real.round(5)} seconds"
