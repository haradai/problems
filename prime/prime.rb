NUM = 1000
max = (NUM ** Rational(1, 2)).to_i
primes = Array.new(NUM) { |e| e+2 }

for i in 2..max do
  primes = primes.select { |e| e == i || e % i != 0 }
end

[2,5,10,19,54,224,312,616,888,977].each do |num|
  puts "#{num} #{primes.select { |e| e < num }.size}"
end
