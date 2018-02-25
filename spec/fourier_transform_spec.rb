Dir["./lib/*.rb"].each {|file| require file }

describe FourierTransform do
  it "#do" do
    input  = [-1,1,-1,-1,-1,-1,1,-1]
    output = [-4, 0, 0, -4, 0, -4, 4, 0]
    expect(FourierTransform.do(input)).to eq output
    expect {
      FourierTransform.do([-1,1,-1])
    }.to raise_error
  end
end