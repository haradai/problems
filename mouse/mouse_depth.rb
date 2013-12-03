# coding: utf-8
# ネズミはチーズがお好き？
# https://codeiq.jp/challenge.php?challenge_id=564
# これは深さ優先で探索しているので、最短を求める分には不適切。一応2分くらいで解けはする。

class Mouse
  attr_reader :min_moves

  class << self
    # 探索のメインメソッド
    # Mouse.searchで開始。
    def search
      m = Mouse.new
      puts "Start! #{Time.now}"
      (1..8).each do |d|
        m.move coord(d, [0,0]), [[0,0]]
      end
      puts "Goal! #{Time.now}"
      puts "#{m.min_moves.size - 1} moves."
      puts "#{m.min_moves.inspect}"
    end

    # チーズの場所を示す配列
    def cheeses
      [[0,2],[0,4],[1,2],[1,4],[2,0],[2,1],[3,3],[4,1]]
    end

    # @param [Fixnum] direction 方向を表す1..8の数値
    # @param [Array<Fixnum,Fixnum>] current_coord 現在位置
    # @return [Array<Fixnum,Fixnum>] 移動先の座標
    def coord direction, current_coord
      x, y = current_coord[0], current_coord[1]
      case direction
      when 1; [x + 2, y - 1]
      when 2; [x + 1, y - 2]
      when 3; [x - 1, y - 2]
      when 4; [x - 2, y - 1]
      when 5; [x - 2, y + 1]
      when 6; [x - 1, y + 2]
      when 7; [x + 1, y + 2]
      when 8; [x + 2, y + 1]
      end
    end
  end

  def initialize
    @min_moves = nil
  end

  # @param Array<Fixnum,Fixnum> new_move 座標
  # @param [Array<Array>] history
  def move new_move, history
    unless history.include? new_move
      if new_move[0].between?(0, 4) && new_move[1].between?(0, 4)
        # 動ける
        history |= [new_move]
        # puts "Moved. #{history.inspect}"
        # 判定
        if eaten? history
          # 終了
          # puts "Finished. #{history.size-1} moves."
          @min_moves ||= history
          if history.size < @min_moves.size
            @min_moves = history
            puts @min_moves.inspect
          end
        else
          # 終了していない
          (1..8).each do |d|
            move Mouse.coord(d, new_move), history
          end
        end
      else
        # 動けない
        # do nothing.
      end
    else
      # 動けない
      # do nothing.
    end
  end

  def eaten? history
    return false if history.nil? || history.size == 0
    eaten = true
    Mouse.cheeses.each do |e|
      eaten &&= history.include? e
    end
    eaten
  end
end

Mouse.search
