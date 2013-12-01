$fib = [0, 1]

def fibonacci n
  $fib[n] ||= fibonacci(n-1) + fibonacci(n-2)
end

1000.times do |i|
  sum = 0
  num = fibonacci i
  next if num == 0
  num.to_s.length.times do |c|
    sum += num.to_s[c].to_i
  end
  puts num if num % sum == 0
end
