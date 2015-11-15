require './setting.rb'
require './gene.rb'

#
# InitializePOPクラスは
# 初期個体群をランダム作り出します。
# 乱数0,1をLENGTH個生成して、個体geneを作ります。
# 個体群popはgeneの集合体です。
#
# 使用例
# require './initialize_pop.rb'
# init_pop = InitializePOP.new
# pop = init_pop.pop
#
# 0と1の遺伝子しか作れないので問題に応じてクラスを拡張していってください。
#
#
class InitializePOP
  attr_reader :pop
  def initialize
    @pop = []
    (1..POPSIZE).each do |i|
      gene = Gene.new
      (1..LENGTH).each do |j|
        gene.gene << Random.rand(0..1)
      end
      @pop << gene
    end
  end
end
