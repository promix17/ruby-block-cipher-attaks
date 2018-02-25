Dir["./lib/*.rb"].each {|file| require file }

class Array
  def matrix_print(shift = 4)
    i = 0
    print i.to_s.rjust(shift)
    for j in 0...self[0].size do
      print j.to_s.rjust(shift)
    end
    self.each do |a|
      puts ''
      print i.to_s.rjust(shift)
      a.each do |item|
        print item.to_s.rjust(shift)
      end
      i += 1
    end
    puts ''
  end

  def print_row(row, shift = 4)
    for j in 0...self[row].size do
      print j.to_s.rjust(shift)
    end
    puts ''
    self[row].each do |item|
      print item.to_s.rjust(shift)
    end
    puts ''     
  end

  def print_col(col, shift = 4)
    self.transpose.print_row(col)
  end
end
