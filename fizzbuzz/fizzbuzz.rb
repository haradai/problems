(1..100).each do |n|
  s = ""
  s += "Fizz" if n % 3 == 0
  s += "Buzz" if n % 5 == 0
  puts s == "" ? n : s
end

Array.new(100){|i|i+1}.each{|e|puts (s=[*["Fizz","",""]*100][e]+[*["Buzz","","","",""]*100][e])==""?e:s}
