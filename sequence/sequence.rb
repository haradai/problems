# coding: utf-8
# 等差数列
# http://nabetani.sakura.ne.jp/hena/ord11arithseq/

class ProblemSequence
  def initialize
    @set = %w(0 1 2 3 4 5 6 7 8 9 a b c d e f g h i j k l m n o p q r s t u v w x y z)
  end

  def main input
    max = 0
    max_seq = ""

    input.chars.each_with_index do |c, i|
      # 数列の最初の数字c
      fix_num = @set.index c
      seq = c

      (i+1..input.size-1).each do |idx|
        # cの次の文字
        c2 = input[idx]
        # c2に対応する数字
        cur_num = @set.index c2

        # 等差数列を構成する文字列
        seq = c + c2

        # c2 と c の差: cur_num - fix_num
        diff = cur_num - fix_num

        # c, c2につづく、数列をなす次の数字
        cur_num += diff
        # c, c2につづく、数列をなす次の文字
        next_char = cur_num > @set.length ? nil : @set[cur_num]
        range_start_index = idx + 1

        while input.chars[range_start_index..-1].include? next_char do
          # 数列に追加
          seq += next_char
          range_start_index = input.index(next_char) + 1
          cur_num += diff
          next_char = cur_num > @set.length ? nil : @set[cur_num]
        end
        if seq.size > max
          max = seq.size
          max_seq = seq
        end
      end
      if seq.size > max
        max = seq.size
        max_seq = seq
      end
    end
    [max, max_seq]
  end
end

#p = ProblemSequence.new
#puts p.main "012abku"
