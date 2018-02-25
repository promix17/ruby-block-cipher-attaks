Dir["./lib/*.rb"].each {|file| require file }

describe Math do
  it '#log2' do
    for i in 0...10 do
      expect(Math.log2(2**i)).to eq i
    end
  end

  it 'pow2?' do
    for i in 0...10 do
      expect(Math.pow2?(2**i)).to eq true
    end
    expect(Math.pow2?(5)).to eq false
  end
end