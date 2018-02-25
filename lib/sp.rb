Dir["./lib/*.rb"].each {|file| require file }
require 'colorize'

class SP
  attr_reader :rounds
  attr_reader :sbox, :sbox_count, :sbox_size
  attr_reader :pbox, :pbox_size  
  attr_reader :sbox_show, :pbox_show

  attr_accessor :print_widht

  def initialize(params)
    @sbox = SBox.from_perm(params[:sbox])
    @pbox = PBox.new(params[:pbox])
    @rounds     = params[:rounds]
    @pbox_size  = @pbox.size
    @sbox_size  = @sbox.n
    throw 'Invalid size' if @pbox_size % @sbox_size != 0
    @normal_c_matrix = @sbox.normal_c_matrix
    @print_widht     = 4
    @sbox_count = @pbox_size/@sbox_size
    @p_matrix   = @sbox.p_matrix
    @d_matrix   = @sbox.d_matrix
    @c_matrix   = @sbox.c_matrix
    null_showing_data    
  end

  def manual_lin_analyse
    manual_analyse(@c_matrix, @normal_c_matrix, true, proc { |val| 0.5 + val/2.0})
  end

  def manual_dif_analyse
    manual_analyse(@d_matrix, @p_matrix, false, proc { |val| val })
  end

  def show
    for i in 0...@rounds do
      print_row(@sbox_show[i])
      print_s_boxes
      print_row(@pbox_show[i])
      print_p_box
    end
    print_row(@sbox_show[@rounds])
    puts ''
  end

  private

   def manual_analyse(matrix_to_display, matrix, transpose, probability_calculator)
    current_value = 1.0
    null_showing_data
    show
    matrix_to_display.matrix_print
    print "\nEnter SBox number: "
    sbox  = gets.to_i
    print "\nEnter SBox input : "
    input = gets.to_i

    input_layer       = Array.new(@sbox_count, Array.new(@sbox_size, 0))
    input_layer[sbox] = input.to_bit_array(@sbox_size)
    @sbox_show[0]     = input_layer.flatten

    for i in 0...@rounds do
      puts "\nP = #{probability_calculator.call(current_value)}"
      puts ''
      show
      break if i==@rounds - 1
      sbox_index = 0
      temp_layer = []
      @sbox_show[i].each_slice(@sbox_size) do |slice|
        if slice==Array.new(@sbox_size, 0)
          temp_layer << slice
        else
          input  = slice.from_bit_array          
          transpose ? matrix_to_display.print_col(input) : matrix_to_display.print_row(input)
          print "\n(Round #{i}) '#{sbox_index}' SBox output: "
          output = gets.to_i
          current_value *= transpose ? matrix[output][input] : matrix[input][output]
          temp_layer << output.to_bit_array(@sbox_size)
          puts ''
        end
        sbox_index += 1
      end
      @pbox_show[i]   = temp_layer.flatten
      @sbox_show[i+1] = @pbox.apply(@pbox_show[i])
    end   
  end

  def null_showing_data
    null_vector       = Array.new(@pbox_size, 0)
    @sbox_show = Array.new(@rounds + 1, null_vector)
    @pbox_show = Array.new(@rounds, null_vector)
  end

  def print_row(row)
    i = 0
    @sbox_count.times do
      @sbox_size.times do
        if row[i]==1
          print " #{row[i]}".red
        else
          print " #{row[i]}"
        end
        i += 1
      end
      print ' '
    end
    puts ''
  end

  def print_p_box
    print_line
    str     = 'P'.center(@sbox_count*(@sbox_size*2+1))
    str[0]  = '|'
    str[-1] = '|'
    puts str
    print_line
  end

  def print_s_boxes
    print_line
    @sbox_count.times do
      str     = 'S'.center(@sbox_size*2+1)
      str[0]  = '|'
      str[-1] = '|'
      print str
    end
    puts ''
    print_line
  end

  def print_line
    @sbox_count.times do
      @sbox_size.times do
        print '--'
      end
      print '-'
    end
    puts ''
  end
end