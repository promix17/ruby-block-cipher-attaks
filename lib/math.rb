Dir["./lib/*.rb"].each {|file| require file }

module Math
  module_function

  def log2(n)
    (Math.log(n)/Math.log(2)).to_i
  end
  
  def pow2?(n)
    n&(n-1)==0
  end

  def scalar(v1, v2)
    throw 'Invalid size' if v1.size != v2.size
    result = []
    for i in 0...v1.size do
      result << v1[i]*v2[i]  
    end
    return result
  end
end