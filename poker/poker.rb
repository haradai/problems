# coding: utf-8
# ポーカー
# http://qiita.com/Nabetani/items/cbc3af152ee3f50a822f

class Cards
  attr_reader :hands_got, :raw_cards

  def initialize cards
    @raw_cards = cards
    @hands_got = {
      pair:        0,
      three_cards: false,
      flash:       false,
      straight:    false,
      broadway:    false,
      four_cards:  false,
    }
  end

  # 手札の数値のみの配列
  # @return [Array<Fixnum>] 数値のみ情報に持つサイズ5の配列
  def ranks
    raw_cards.map do |card|
      myconvert card[1..-1]
    end
  end

  # 手札のスート情報のみの配列
  # @return [Array<String>] スート情報のみ持つサイズ5の配列
  def suits
    raw_cards.map { |c| c[0] }
  end

  # 手札の役を判定する
  # hands_gotハッシュを更新
  # @return [String] 以下の文字列を返す
  #   "4K"  フォーオブアカインド
  #   "RSF" ロイヤルストレートフラッシュ
  #   "BW"  ブロードウェイ
  #   "SF"  ストレートフラッシュ
  #   "ST"  ストレート
  #   "FH"  フルハウス
  #   "3K"  スリーオブアカインド
  #   "2P"  ツーペア
  #   "1P"  ワンペア
  #   "--"  手無し
  def hands
    count = [0] * 14

    # ストレートの判定
    sorted = ranks.sort
    if sorted.map { |e| e.to_i - sorted[0].to_i } == [0,1,2,3,4]
      hands_got[:straight] = true
    elsif sorted == [1,10,11,12,13]
      hands_got[:broadway] = true
    end

    # フラッシュの判定
    hands_got[:flash] = suits.uniq.size == 1

    # 枚数系の役（ペア、スリーカード、フォーカード）判定
    ## 枚数を数える
    ranks.each do |r|
      count[r.to_i] += 1
    end
    count.each do |c|
      hands_got[:pair]        += 1    if c == 2
      hands_got[:three_cards]  = true if c == 3
      hands_got[:four_cards]   = true if c == 4
    end

    # 最終判定
    if hands_got[:four_cards]
      "4K" # フォーオブアカインド
    elsif hands_got[:broadway]
      if hands_got[:flash]
        "RSF" # ロイヤルストレートフラッシュ
      else
        "BW" # ブロードウェイ
      end
    elsif hands_got[:straight]
      if hands_got[:flash]
        "SF" # ストレートフラッシュ
      else
        "ST" # ストレート
      end
    elsif hands_got[:three_cards] && hands_got[:pair] > 0
      "FH" # フルハウス
    elsif hands_got[:three_cards]
      "3K" # スリーオブアカインド
    elsif hands_got[:pair] == 2
      "2P" # ツーペア
    elsif hands_got[:pair] == 1
      "1P" # ワンペア
    else
      "--" # 手無し
    end
  end

  private
  def myconvert rank
    case rank
    when "J"; 11
    when "Q"; 12
    when "K"; 13
    when "A"; 1
    else; rank.to_i
    end
  end
end

cards = %w(S2 S3 S4 S5 S6 S7 S8 S9 S10 SJ SQ SK SA
           H2 H3 H4 H5 H6 H7 H8 H9 H10 HJ HQ HK HA
           D2 D3 D4 D5 D6 D7 D8 D9 D10 DJ DQ DK DA
           C2 C3 C4 C5 C6 C7 C8 C9 C10 CJ CQ CK CA)
c = Cards.new cards.shuffle[0..4]
p c.raw_cards
# p c.ranks
# p c.suits
p c.hands
