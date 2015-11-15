require './setting.rb'

#
# Crossoverは交叉クラスです。
# 以下の交叉演算子を定義してます。
# ・一点交叉
# ・一様交叉
#
# 作成予定
#
# 使用例
# crossover = Crossover.new(~~~.new)
# Crossover_pop = crossover.execute(pop)
#
class Crossover
  def initialize(crossover)
    @crossover = crossover
  end

  def execute(pop)
    @crossover.crossover(pop)
  end
end

#
# ===========================================================
#  ここから交叉に関するクラスを作る
# ===========================================================
# 作成例
# class SampleCrossover
#   def crossover(pop)
#     ここに処理を書く
#   end
# end
#

#
# OnePointCrossover
# 一点交叉を行うクラス
# 交叉点をランダムに選び、交叉点から後ろの遺伝子座を交叉する。
# 選択後のシャッフルされた個体を期待している
#
class OnePointCrossover
  def crossover(pop)
    (0...POPSIZE/2).each do |i|
      point = Random.rand(0...LENGTH)
      (point+1...LENGTH).each do |j|
        tmp = pop[2*i].gene[j]
        pop[2*i].gene[j] = pop[2*i+1].gene[j]
        pop[2*i+1].gene[j] = tmp
      end
    end
    pop
  end
end

#
# UniformCrossover
# 一様交叉を表すクラス
#
class UniformCrossover
  def crossover(pop)
    mask = []
    (0...LENGTH).each do |i|
      mask << Random.rand(0..1)
    end
    (0...POPSIZE/2).each do |i|
      (0...mask.length).each do |j|
        if mask[j] == 1
          pop[2*i].gene[j],pop[2*i+1].gene[j] = pop[2*i+1].gene[j],pop[2*i].gene[j]
        end
      end
    end
    pop
  end
end
