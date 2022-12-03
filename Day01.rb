### Settings ###
doingTest = false
day=1
### Load file ###
filePointer = doingTest ? "input\\day#{day.to_s.rjust(2,'0')}test.txt" 
                        : "input\\day#{day.to_s.rjust(2,'0')}.txt"
if !File.exist?(filePointer)
    warn "You forgot the input, dummy. @ #{filePointer}"
elsif File.zero?(filePointer)
    warn "Input file is empty."
else
    input = File.open(filePointer, "r").map{_1}*''
################
### Solution ###
################
#part 1
puts input.split("\n\n").map{_1.split.map(&:to_i).sum}.max

#part 2
puts input.split("\n\n").map{_1.split.map(&:to_i).sum}.sort[-3..].sum
end
