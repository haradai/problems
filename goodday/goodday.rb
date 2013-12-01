# coding: utf-8
# Usage:
# $ ruby goodday.rb 2012/12/02
# yes
# $ ruby goodday.rb 2012/11/02
# no

# @param  [Array] a 複数の文字列
# @return [Array] a.joinに0〜9の数字がいくつ含まれているかを表すサイズ10の配列
# 例：a[0] = 2 なら、0が2つ含まれてることを表す
# 　　a[9] = 3 なら、9が3つ含まれてることを表す
#    "2009" => [2, 0, 1, 0, 0, 0, 0, 0, 0, 1]となる。
def get *a
  r = [0] * 10
  a.join.split('').each { |c| r[c.to_i] += 1 }
  r
end

puts get($*[0][0..3]) == get($*[0][5..6], $*[0][8..9]) ? "yes" : "no"
