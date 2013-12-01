# coding: utf-8
$price = [nil, 1, 6, 8, 10, 17, 18, 20, 24, 26, 30]
$allarrays = []

# 数値を2つに分割する。
# @param [Fixnum] number 分割対象の数値
# @param [Fixnum] n nとnumber-nに分割する
# @return [Array] numberを2つに分割した配列
def chop number, n
  if n > 0 && number - n > 0
    [n, number-n]
  end
end

# 階層を一段潜り、複数の配列を返す
# @param [Array] array 分割対象の配列
# @return [Array] 「arrayの要素を1度だけ2分割して生成される配列」の配列
def chop_up array
  res_arrays = []
  array.each_with_index do |e, i|
    e.times do |ee|
      if a = chop(e, ee)
        new_array = array.clone
        new_array[i] = a
        res_arrays |= [new_array.flatten.sort]
      end
    end
  end
  $allarrays |= res_arrays
  res_arrays
end

# 再帰を用いて探索
# @param [Array<Array>] arrays 配列の配列
def search arrays
  arrays.each do |array|
    children = chop_up(array)
    unless children.size == 0
      search children
    end
  end
end

def get_price carr
  sum = 0
  carr.each do |num|
    sum += $price[num]
  end
  sum
end

# メイン
search chop_up([10])

max_array = nil
max_price = 0
$allarrays.each_with_index do |array, i|
  price = get_price array
  puts "#{i+1}:\t#{price}万円（#{array.inspect}）"
  if max_price < price
    max_price = price
    max_array = array
  end
end

puts "最大額:\t#{max_price}万円（#{max_array.inspect}）"
