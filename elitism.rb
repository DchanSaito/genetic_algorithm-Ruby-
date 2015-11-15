require './selection.rb'

#
# Elitism
# エリート保存選択を表すクラスです。
# インスタンス変数eliteに世代ごとのエリートを保存します。
# 以下のメソッドを定義してます。
# set_elite:
# エリート個体を保存する。
#
# change_elite:
# 次世代に引き継がれる個体群から最弱な個体をエリート個体に代えます。
#
# find_elite:
# 個体群からエリート個体を見つけます。
#
# find_weak:
# 個体群から最弱な個体を見つける。
# 
class Elitism
  attr_reader :elite_gene
  def initialize
    @elite_gene = nil
  end

  def set_elite(pop)
    @elite_gene = Marshal.load(Marshal.dump(find_elite(pop)))
  end

  def change_elite(pop)
    index = find_weak_index(pop)
    pop[index] = @elite_gene
    p @elite_gene
    pop
  end

  private
  def find_elite(pop)
    pop.max_by do |gene|
      gene.fitness
    end
  end

  def find_weak_index(pop)
    weak = pop.min_by do |gene|
      gene.fitness
    end
    (0...pop.length).each do |i|
      return i if pop[i].fitness == weak.fitness
    end
  end
end
