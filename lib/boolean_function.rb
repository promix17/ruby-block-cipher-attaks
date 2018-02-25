Dir["./lib/*.rb"].each {|file| require file }

class BooleanFunction
  attr_reader :array
  attr_reader :n
  
  def initialize(object, size=nil)
    case object
    when String
      from_string(object)
    when Array
      from_array(object)
    when Method
      from_proc(object, size)
    else
      raise 'Invalid input'
    end
  end

  def self.e(size)
    BooleanFunction.new('1'*(2**size))
  end

  def self.n(size)
    BooleanFunction.new('0'*(2**size))
  end

  def *(op2)
    raise 'Invalid size' if @n != op2.n
    r_array = Array.new(@array)
    for i in 0...r_array.size do
      r_array[i] *= op2.array[i]
    end
    return BooleanFunction.new(r_array)
  end

  alias & *

  def +(op2)
    raise 'Invalid size' if self.n != op2.n
    r_array = Array.new(@array)
    for i in 0...r_array.size do
      r_array[i] ^= op2.array[i]
    end
    return BooleanFunction.new(r_array)
  end

  alias ^ +

  def |(op2)
    raise 'Invalid size' if self.n != op2.n
    r_array = Array.new(@array)
    for i in 0...r_array.size do
      r_array[i] |= op2.array[i]
    end
    return BooleanFunction.new(r_array)
  end
  
  def to_rational_digit
    res = Array.new(@array)
    res.map {|x| x = (x==1 ? -1 : 1) }
  end

  def fourier_transform_1
    FourierTransform.do(@array)
  end
  
  def fourier_transform_2
    FourierTransform.do(to_rational_digit)
  end
  
  def normal_fourier_transform_1
    normalize(fourier_transform_1)
  end
  
  def normal_fourier_transform_2
    normalize(fourier_transform_2)
  end

  def power_spectrum
    fourier_transform_2.map { |x| x**2 }
  end
  
  def auto_correlation
    normalize(FourierTransform.do(power_spectrum))
  end

  private

  def normalize(array)
    array.map{ |x| x /=array.size.to_f }
  end

  def from_string(str)
    throw 'Invalid size' if !Math.pow2?(str.size)
    @n     = Math.log2(str.size)
    @array = str.to_bit_array
  end

  def from_array(array)
    throw 'Invalid size' if !Math.pow2?(array.size)
    @n     = Math.log2(array.size)
    @array = Array.new(array)
    @array.each do |item|
      throw 'Invalid input' if item!=0 && item!=1      
    end    
  end

  def from_proc(f, size)
    throw 'Invalid size' if !Math.pow2?(size)
    @n     = size
    @array = (0...2**size).map { |i| f.call(i.to_bit_array(size)) }    
  end
end