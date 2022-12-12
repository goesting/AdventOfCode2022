require 'benchmark'
1.upto(2){|part|
time = Benchmark.measure{
    f = File.read('input\day12.txt')
    gridSizeX = f.split[0].size
    gridSizeY = f.split.size

    startLoc = f.delete("^a-zSE").index('S')
    xStart = startLoc % gridSizeX
    yStart = startLoc / gridSizeX

    endLoc = f.delete("^a-zSE").index('E')
    xEnd = endLoc % gridSizeX
    yEnd = endLoc / gridSizeX

    if part == 2
        xStart = xEnd
        yStart = yEnd
    end

    directions = [[0,1],[1,0],[-1,0],[0,-1]]

    grid = f.tr('SE','az').split.map{|line| line.chars.map{|letter| letter.ord - 'a'.ord}}
    distances = Array.new(gridSizeY).map{Array.new(gridSizeX, Float::INFINITY)}
    checked = Array.new(gridSizeY).map{Array.new(gridSizeX, false)}

    distances[yStart][xStart] = 0
    connectedNodes = [[xStart,yStart]]
    aFound = false

    while (part == 1 && checked[yEnd][xEnd] == false) or 
          (part == 2 && aFound == false) do
        xBest,yBest = connectedNodes.min_by{|node| distances[node[1]][node[0]]}
        checked[yBest][xBest] = true
        if part == 2 && grid[yBest][xBest] == 0
            aFound = true
            puts "The closest A to the end is #{distances[yBest][xBest]} steps away."
        end
        directions.each{|direction|
            xNew,yNew = xBest + direction[1],yBest + direction[0]
            unless [xNew,yNew].min < 0 or xNew > gridSizeX - 1 or yNew > gridSizeY - 1 or checked[yNew][xNew] or 
            (grid[yNew][xNew]-grid[yBest][xBest])*(part == 1 ? 1 : -1) > 1
                distances[yNew][xNew] = [distances[yBest][xBest] + 1,distances[yNew][xNew]].min
                connectedNodes << [xNew, yNew] unless connectedNodes.include?([xNew,yNew])
            end
        }
        connectedNodes.delete([xBest,yBest])
    end
    puts "The shortest path to E is in #{distances[yEnd][xEnd]} steps." if part == 1}
puts "Time for part #{part} = #{time.real.round(5)} seconds"}
