# coding: utf-8
class Graph
  attr_accessor :graph, :edges, :node_num, :info

  def initialize num
    @node_num = num
    @graph = Array.new(num) { |i| i+1 }
    init_edge
    update
  end

  def to_s
    "ノード数: #{node_num}\nエッジ数: #{edges.size}\nエッジ: #{edges.inspect}\n経路: #{@pathes.inspect}"
  end

  # グラフが変更されるのでupdate必須
  def query edge
    if edges.include? edge.sort!
      @edges -= [edge]
    else
      @edges |= [edge]
    end
    update
    self
  end

  # クエリーと判定
  def query_and_judge q
    query q
    puts is_forest?
  end

  # 判定メソッド
  def is_forest?
    info.each_with_index do |neighbors, cur|
      next if cur == 0
      search cur, neighbors, [cur]
    end
    @is_forest ? "yes" : "no"
  end

  private
  # 探索メソッド
  def search cur, neighbors, path
    # puts "現在:#{cur}, 近傍:#{neighbors.inspect}, 経路:#{path.inspect}" #debug
    return unless @is_forest
    if neighbors && neighbors.size > 0
      neighbors.each do |nex|
        if path.include? nex
          # 閉路の発見
          @is_forest = false
          # puts "閉路!森ではない #{(path + [nex]).inspect}"
          @pathes |= [path + [nex]]
        else
          search nex, info[nex]-[cur], path + [nex]
        end
      end
    else
      # neighborsが空
      @pathes |= [path]
    end
  end

  # グラフ更新に伴う処理
  def update
    create_info

    # 経路配列（要素内要素は当然ソートしちゃダメ）
    # たとえば4=>2=>3=>5と経路を辿った場合[4,2,3,5]が要素として保存される。
    @pathes = []

    # 森かどうか
    @is_forest = true
  end

  # エッジを初期化
  def init_edge
    @edges = []
    (1..node_num).each do |n|
      (2..node_num).each do |m|
        @edges |= [[n,m].sort] unless n == m
      end
    end
  end

  # 隣接情報を作成する
  def create_info
    @info = []
    graph.each do |n|
      neighbors = [] # nの隣接ノードの集合
      edges.each do |edge|
        neighbors |= edge - [n] if edge.include? n
      end
      info[n] = neighbors
    end
  end
end

g = Graph.new(3)
puts g
g.query_and_judge [1, 2]
puts g
g.query_and_judge [1, 2]
puts g
g.query_and_judge [2, 3]
puts g
g.query_and_judge [1, 2]
puts g

g = Graph.new(4)
puts g
g.query_and_judge [1, 2]
puts g
g.query_and_judge [1, 4]
puts g
g.query_and_judge [2, 3]
puts g
g.query_and_judge [3, 4]
puts g
