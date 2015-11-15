require './setting.rb'

#
# Fitnessは
# 評価に値し、適応度を計算するインターフェース
# デザインパターンのstrategyを採用
# スケーリングもここで実装
#
# 使用例
# fitness = Fitness.new(Sample.new)
# fitness.execute(pop)
#
#
class Fitness
  attr_reader :description
  def initialize(description)
    @description = description
  end

  def execute(pop)
    @description.calculate(pop)
  end
end

#
# ==============================================================
#  ここから先問題に対しての適応度を計算するクラスを作る
# ==============================================================
# 作成例
# class Sample
#   def calculate(gene)
#     ここに処理を書く
#   end
# end

class BitCount
  def calculate(pop)
    pop.each do |gene|
      sum = 0
      gene.gene.each do |bit|
        sum += 1 if bit == 1
      end
      gene.fitness = sum
    end
  end
end

