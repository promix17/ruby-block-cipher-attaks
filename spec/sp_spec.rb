Dir["./lib/*.rb"].each {|file| require file }

describe SP do
  it '#initialize' do
    expect {
      SP.new(
        :pbox   => [0,1,2,3],
        :sbox   => [0,1,2,3],
        :rounds => 4
      )
    }.not_to raise_error   
  end
end