Dir["./lib/*.rb"].each {|file| require file }

describe PBox do  
  it '#initialize' do
    expect {
      PBox.new([2,1,2])
    }.to raise_error
    p = PBox.new([2,0,1])
    expect(p.array).to eq [2, 0, 1]
    expect(p.back).to  eq [1, 2, 0]
  end 

  it '#apply' do
    p = PBox.new([3,2,1,0])
    expect(p.apply(['a','b','c','d'])).to eq ['d','c','b','a']
  end
end