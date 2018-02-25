Dir["./lib/*.rb"].each {|file| require file }

describe SBox do
  before(:all) do
    @test = SBox.new(['0001', '1110'])
  end
  
  it '#initialize' do
    expect {
      sbox = SBox.new(['0001', '1110'])
    }.not_to raise_error
    expect {
      sbox = SBox.new(['01', '1110'])
    }.to raise_error
  end

  it '#c_matrix' do
    expect(@test.c_matrix).to eq [[4,0,0,0],[-2,-2,-2,2],[2,2,2,-2],[-4,0,0,0]]
  end

  it '#normal_c_matrix' do
    expect(@test.normal_c_matrix).to eq [
      [ 1.0, 0.0, 0.0, 0.0],
      [-0.5,-0.5,-0.5, 0.5],
      [ 0.5, 0.5, 0.5,-0.5],
      [-1.0, 0.0, 0.0, 0.0]
    ]
  end

  it '#d_matrix' do
    expect(@test.d_matrix).to eq [
      [4, 0, 0, 0],
      [2, 0, 0, 2],
      [2, 0, 0, 2],
      [2, 0, 0, 2]
    ]
  end

  it '#p_matrix' do
    expect(@test.p_matrix).to eq [
      [1.0, 0.0, 0.0, 0.0], 
      [0.5, 0.0, 0.0, 0.5], 
      [0.5, 0.0, 0.0, 0.5], 
      [0.5, 0.0, 0.0, 0.5]
    ]
  end
end