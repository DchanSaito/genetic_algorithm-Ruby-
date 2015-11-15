require './setting.rb'


#
# Mutation
# 突然変異を表すクラスです。
# 以下の突然変異演算子を定義してます。
# ・ビット型の突然変異
# 作成予定
#
# 使い方は簡単です。
# mutation = Mutation.new(~.new)
# pop = mutation.execute(pop)
#
class Mutation
  def initialize(mutation)
    @mutation = mutation
  end

  def execute(pop)
    @mutation.mutate(pop)
  end
end

#
#========================================================
# ここから突然変異に関するクラスを作る
#========================================================
#
# 作成例
# class SampleMutation
#   def mutate(pop)
#     ここに処理を書く
#   end
# end
#

#
# BitMutation
# バイナリ列の染色体に対して行う突然変異クラスです。
#
class BitMutation
  def mutate(pop)
    pop.each do |gene|
      gene.gene = mutate_locus(gene.gene)
    end
    pop
  end

  private
  #
  # 遺伝子の遺伝子座に対して突然変異を行うメソッド
  #
  def mutate_locus(gene)
    (0...gene.length).each do |i|
      if(Random.rand(0..1.0) < MRATE)
        if gene[i] == 0
          gene[i] = 1
        else
          gene[i] = 0
        end
      end
    end
    gene
  end
end
