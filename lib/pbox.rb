Dir["./lib/*.rb"].each {|file| require file }

class PBox
  attr_reader :array
  attr_reader :back
  attr_reader :size

  def initialize(array)
    @size  = array.size
    @array = Array.new(array)
    @back  = Array.new(@size)
    for i in 0...@size do
      @back[@array[i]] = i
    end    
    raise 'Invalid permutation' if !@back.all? 
  end

  def apply(array)
    raise 'Invalid size' if @size != array.size
    result = Array.new(@size)
    for i in 0...@size do
      result[@array[i]] = array[i]
    end
    return result
  end
end
