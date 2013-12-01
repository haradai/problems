n, bowls, plates, types = nil

f = open $*[0]
f.each_with_index do |line, i|
  n, bowls, plates = line.split(' ').map(&:to_i) if i == 0
  types = line.split(' ') if i == 1
end
f.close

bowl_dish           = types.select { |s| s=="1" }.size
bowl_or_plates_dish = types.select { |s| s=="2" }.size

# puts "#{n} bowls=#{bowls} plates=#{plates} types=#{types}" #debug
# puts "b=#{b} bp=#{bp}" #debug

wash_bowls  = bowl_dish - bowls
wash_plates = bowl_or_plates_dish - plates

wash_times =
  if wash_bowls > 0
    wash_plates > 0 ? wash_bowls + wash_plates : wash_bowls
  else
    wash_plates > 0 ? wash_plates              : 0
  end

puts wash_times > 0 ? wash_times : 0
