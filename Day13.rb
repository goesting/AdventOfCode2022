require 'benchmark'
require 'json'
day13_sort = Proc.new do |a,b| #compare 2 items for sorting. return -1 if first is smaller,0 if equal and 1 if last is smaller
    sortOrder = 0
    [a.size, b.size].max.times { |i|
      if a[i].nil?
        sortOrder = -1
      elsif b[i].nil?
        sortOrder = 1
      elsif a[i].kind_of?(Array) && b[i].kind_of?(Array)
        sortOrder = day13_sort.call(a[i], b[i])
      elsif a[i].kind_of?(Array) && b[i].kind_of?(Integer)
        sortOrder = day13_sort.call(a[i], [b[i]])
      elsif a[i].kind_of?(Integer) && b[i].kind_of?(Array)
        sortOrder = day13_sort.call([a[i]], b[i])
      else
        sortOrder = a[i] <=> b[i]
      end
      if sortOrder != 0
        break
      end
    }
    sortOrder
  end
### PART 1 ###
time = Benchmark.measure{puts "The sum of incorrectly sorted indices = #{File.read('input\day13.txt').split("\n\n").map{|block| block.split.map{|line| JSON.parse(line)}}.map!.with_index{|block,i| block.sort(&day13_sort) == block ? i+1 : 0}.sum}"}
puts "Time for part 1 = #{time.real.round(5)} seconds"

### PART 2 ###
time = Benchmark.measure{
    f = (File.read('input\day13.txt') + "\n[[2]]\n[[6]]").split("\n").reject{_1==""}.map{|block| block.split.map{|line| JSON.parse(line)}}.sort(&day13_sort)
    puts "The product of divides packet indices = #{(f.index([[[2]]])+1) * (f.index([[[6]]])+1)}"
}
puts "Time for part 2 = #{time.real.round(5)} seconds"
