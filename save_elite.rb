require './setting.rb'

class SaveElite
  def initialize(pop)
    @setting = Setting.new
    @fitness = Fitness.new
    best_fitness = @fitness.fitness(pop[0])
    best_number  = 0

  end
end
