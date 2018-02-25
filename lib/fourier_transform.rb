Dir["./lib/*.rb"].each {|file| require file }

module FourierTransform
  module_function

  def do(array)
  	raise 'Invalid size' if !Math.pow2?(array.size)
    array = Array.new(array)
    for i in 0...Math.log2(array.size) do
      temp = Array.new(array.size)    
      block_size = 2**(i+1)
      for j in 0...array.size/block_size do
        for k in 0...block_size/2 do
          base   = j*block_size
          index1 = base + k
          index2 = base + block_size/2 + k
          val1   = array[index1] + array[index2]
          val2   = array[index1] - array[index2]
          temp[index1] = val1
          temp[index2] = val2
        end
      end      
      array = Array.new(temp)      
    end
    return array    
  end
end