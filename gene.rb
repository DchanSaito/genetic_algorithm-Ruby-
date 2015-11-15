
#
# 遺伝子表現の設定
# Dont touch this class
# 
class Gene
  attr_accessor :gene, :fitness
  def initialize
    @gene = [] 
    @fitness = nil
  end
end
