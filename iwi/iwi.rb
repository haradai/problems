# coding: utf-8
# 問題 B : (iwi)
# http://www.utpc.jp/2011/problems/iwi.html

def edge l, r
  (l == 'i' && r == 'i') || (l == 'w' && r == 'w') ||
    (l == '(' && r == ')') || (l == ')' && r == '(')
end

def symmetric_distance str, ans
  if str.size < 2
    ans += 1 unless str == 'i' || str == 'w' || str == ''
    ans
  else
    ans += 1 unless edge(str[0], str[-1])
    symmetric_distance str[1..-2], ans
  end
end

puts symmetric_distance $*[0], 0
