# coding: utf-8
# ネズミはチーズがお好き？
# https://codeiq.jp/challenge.php?challenge_id=564
# mouse4.rb: 幅優先の全探索で最短距離を求める。結構時間がかかった orz

class Mouse
  attr_reader :min_moves

  class << self
    # 探索のメインメソッド
    # Mouse.searchで開始。
    def search
      m = Mouse.new
      puts "Start! #{Time.now}"
      m.seek [[[0,0]]]
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

  # @param [Array1<Array2<Array3>>] histories 探索履歴の集合
  # [Array2<Array3>] history 探索履歴
  # [Array3] node 通過ノード
  def seek histories
    while true do
      new_histories = []
      histories.each do |history|
        (1..8).each do |d|
          new_history = move Mouse.coord(d, history[-1]), history
          return new_history if @min_moves
          new_histories |= [new_history] if new_history
        end
      end
      histories = new_histories
    end
  end

  def move new_move, history
    unless history.include? new_move
      if new_move[0].between?(0, 4) && new_move[1].between?(0, 4)
        history |= [new_move]
        @min_moves = history if eaten? history
        history
      end
    end
  end


  # # @param Array<Fixnum,Fixnum> new_move 座標
  # # @param [Array<Array>] history
  # def move new_move, history
  #   unless history.include? new_move
  #     if new_move[0].between?(0, 4) && new_move[1].between?(0, 4)
  #       # 動ける
  #       history |= [new_move]
  #       # puts "Moved. #{history.inspect}"
  #       # 判定
  #       if eaten? history
  #         # 終了
  #         # puts "Finished. #{history.size-1} moves."
  #         @min_moves ||= history
  #         if history.size < @min_moves.size
  #           @min_moves = history
  #           puts @min_moves.inspect
  #         end
  #       else
  #         # 終了していない
  #         (1..8).each do |d|
  #           move Mouse.coord(d, new_move), history
  #         end
  #       end
  #     else
  #       # 動けない
  #       # do nothing.
  #     end
  #   else
  #     # 動けない
  #     # do nothing.
  #   end
  # end

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
