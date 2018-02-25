Dir["./lib/*.rb"].each {|file| require file }

class String
  def to_bit_array(size=nil)
    array = []
    each_char do |item|
      case item
      when '0'
        array << 0
      when '1'
        array << 1
      else
        throw 'Invalid char'
      end
    end
    size && array = Array.new(size - array.size, 0) + array
    return array
  end
end

class Fixnum
  def to_bit_array(size=nil)
    to_s(2).to_bit_array(size)
  end
end

class Array
  def from_bit_array
    inject(0) { |r, x| r*2 + x }
  end
end
