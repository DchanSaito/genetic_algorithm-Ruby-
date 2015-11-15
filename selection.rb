 './setting.rb'


#
# Selectionは選択クラスです。
# 以下の選択演算子を定義してます。
# ・適応度比例選択(ルーレット選択式の個体数回回す方式)
# ・トーナメント選択
# 作成予定
# ・適応度比例選択(針を均等に並べる方法)
# ・熱力学的選択方法
#
# 使用例
# select = Selection.new(RouletteSelection.new)
# selectpop = select.execute
#
class Selection
  def initialize(selection)
    @selection = selection
  end

  def execute(pop)
    @selection.select(pop)
  end
end


#
# ==============================================================
# ここから選択に関してのクラスを作る
# ==============================================================
# 作成例
# class SampleSelection
#   def select(fitness)
#     ここに処理を書く
#   end
# end
#

#
# RouletteSelection
# 適応度比例選択のルーレット選択を表すクラス
# 適応度に比例した幅をもつルーレットを回して
# 選ばれた個体を選択します。
#
# candidate_popは選ばれたpopを返す
#
class RouletteSelection
  def select(pop)
    sum = 0.0
    candidate_pop = []
    pop.each { |gene| sum += gene.fitness.to_f }
    #ルーレットの針を回してみる
    (0...pop.length).each do |i|
      needle = Random.rand(0.0..sum)
      candidate_pop << search(needle,pop)
    end
    candidate_pop
  end

  private
  #
  # ルーレットの針が刺した個体を返す
  #
  def search(needle, pop)
    i = 0
    while(needle >= 0.0)
      needle -= pop[i].fitness
      i += 1
    end
    pop[i-1]
  end
end

#
# TournamentSelection
# トーナメント選択を表すクラスです
# トーナメントサイズの数だけ個体群から個体を取り出して
# その中から一番適応度の高い個体を選択します。
# もし、最大適応度を持つ個体が複数存在したら平等な確率で１つ選びます。
# この操作を個体数回繰り返します。
#
class TournamentSelection
  def select(pop)
    candidate_pop = []
    tournament_size = set_tournament_size(pop.length)
    buffer = [] # 適応度の等しい個体の争い
    (0...pop.length).each do |i|
      candidate_numbers = make_number(tournament_size, pop.length)
      max_fitness = max_fitness_in_chosen_genes(pop, candidate_numbers)
      candidate_numbers.each do |number|
        buffer << number if max_fitness == pop[number].fitness
      end
      candidate_pop << pop[buffer.sample]
    end
    candidate_pop
  end

  private
  #
  # トーナメントサイズをチェックする
  #
  def set_tournament_size(pop_length)
    if DEFAULT_TOURNAMENT_SIZE <= pop_length
      return DEFAULT_TOURNAMENT_SIZE
    else
      raise 'DEFAULT_TOURNAMENT_SIZE over POPSIZE'
    end
  end
  #
  # 選ばれた遺伝子から適応度の最大値を返す
  #
  def max_fitness_in_chosen_genes(pop, candidate_numbers)
    choice_fitnesses = []
    candidate_numbers.each do |number|
      choice_fitnesses << pop[number].fitness
    end
    choice_fitnesses.sort!
    return choice_fitnesses[-1]
  end
  #
  # 重複なしに個体をトーナメントサイズ分だけランダムに選択する
  #
  def make_number(tournament_size, pop_length)
    [*(0..pop_length-1)].sample(tournament_size)
  end
end

#
# ThermoDynamicalSelection
# 熱力学的選択を表すクラスです。
# 温度のパラメータを用いて多様性を制御可能
#
class ThermoDynamicalSelection
  def select(pop)

  end
end
