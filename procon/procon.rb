# coding: utf-8
# 問題 A : プログラミングコンテスト
# http://www.utpc.jp/2011/problems/jam.html

file = File.open('in.txt')
max = 0
begin
  file.each_line.with_index(0) do |line, i|
    next if i == 0
    solved = line.split(' ').map(&:to_i).inject(:+)
    max = solved if solved > max
  end
ensure
  file.close
end
puts max
