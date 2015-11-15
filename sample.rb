#
# ---------------------------------------
#                使用例
# ---------------------------------------
#

#
# ビットカウントを行ってみた
# (1, 1, 1, ..., 1)となるようなバイナリ列をGAで求める
#

require './fitness.rb'
require './initialize_pop.rb'
require './selection.rb'
require './crossover.rb'
require './mutation.rb'
require './elitism.rb'

init_pop = InitializePOP.new
fitness = Fitness.new(BitCount.new)
ope = Selection.new(TournamentSelection.new)
# ope = Selection.new(RouletteSelection.new)
# ope2 = Crossover.new(OnePointCrossover.new)
ope2 = Crossover.new(UniformCrossover.new)
ope3 = Mutation.new(BitMutation.new)
elitism = Elitism.new

pop = init_pop.pop
fitness.execute(pop)

p "初期遺伝子"
# p pop
200.times do
  p "set Elite"
  p elitism.set_elite(pop)
  pop = ope.execute(pop)
  pop = ope2.execute(pop)
  pop = ope3.execute(pop)
  fitness.execute(pop)
  p "change elite"
  pop = elitism.change_elite(pop)
end

p "終了"
# p pop
p "エリート"
elitism.set_elite(pop)
p elitism.elite_gene
