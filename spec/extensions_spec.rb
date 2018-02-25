Dir["./lib/*.rb"].each {|file| require file }

describe String do
  it '#to_bit_array' do
    expect('101'.to_bit_array).to eq [1,0,1]
    expect('101'.to_bit_array(4)).to eq [0,1,0,1]
    expect {
      '102'.to_bit_array
    }.to raise_error
  end
end

describe Fixnum do
  it '#to_bit_array' do
    expect(3.to_bit_array).to eq [1,1]
    expect(3.to_bit_array(3)).to eq [0,1,1]
  end
end

describe Array do
  it '#from_bit_array' do
    expect([1,1].from_bit_array).to eq 3
    expect([1,0,1,1].from_bit_array).to eq 11
    expect([0,1,1].from_bit_array).to eq 3
    expect([0,1,0,1,1].from_bit_array).to eq 11
  end
end
