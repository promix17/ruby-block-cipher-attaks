Dir["./lib/*.rb"].each {|file| require file }
require 'matrix'

class SBox
  attr_reader :array
  attr_reader :n

  def initialize(array)
    @array = array.map { |item| BooleanFunction.new(item)}   
    @n     = @array[0].n
    @array.each do |item|
      raise 'Invalid size' if item.n != @n
    end
  end

  def self.from_perm(array)
    raise 'Invalid size' if !Math.pow2?(array.size)
    size = Math.log2(array.size)
    bits = array.map { |x| x.to_bit_array(size) }
    SBox.new(bits.transpose)
  end

  def normal_c_matrix
    c_matrix.map do |line|
      line.map do |x|
        x /= 2.0**@n
      end
    end
  end

  def c_matrix
    result = []
    for i in 0...2**array.size do
      coeff = i.to_bit_array(array.size).map do |x| 
        x==0 ? BooleanFunction.n(@n) : BooleanFunction.e(@n)
      end 
      result << Math.scalar(coeff,@array).inject(BooleanFunction.n(@n)){|r, x| r + x }.fourier_transform_2     
    end
    return result
  end

  def p_matrix
    cmatrix = normal_c_matrix
    result  = Array.new(2**@n).map!{Array.new(2**@array.size, 0)}
    for i in 0...2**@n do 
      for j in 0...2**@array.size do
        sum = 0.0
        for k in 0...cmatrix.size do
          for m in 0...cmatrix[0].size do
            s1 = Math.scalar(
              m.to_bit_array(cmatrix[0].size),
              i.to_bit_array(2**@n)
            ).inject(0) {|r, x| r ^ x }
            s2 = Math.scalar(
              k.to_bit_array(cmatrix.size),
              j.to_bit_array(2**@array.size),
            ).inject(0) {|r, x| r ^ x }
            tmp  = (-1)**(s1 + s2)
            sum += tmp*(cmatrix[k][m].to_f**2)
          end
        end
        result[i][j] = sum/(2**@array.size)
      end
    end
    return result
  end

  def d_matrix
    p_matrix.map do |line|
      line.map do |x|
        (x *= 2**@n).to_i
      end
    end
  end
end