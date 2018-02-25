#!/usr/bin/ruby
Dir["./lib/*.rb"].each {|file| require file }

sp = SP.new(
  :pbox   => [1, 5, 9, 13, 2, 6, 10, 14, 3, 7, 11, 15, 4, 8, 12, 16].map {|x| x-1},
  :sbox   => [14, 4, 13, 1, 2, 15, 11, 8, 3, 10, 6, 12, 5, 9, 0, 7],
  :rounds => 4
)

#sp.manual_lin_analyse
#sp.manual_dif_analyse