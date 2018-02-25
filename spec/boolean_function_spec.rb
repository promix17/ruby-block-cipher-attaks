Dir["./lib/*.rb"].each {|file| require file }

describe BooleanFunction do
  before(:all) do
    @test = BooleanFunction.new([1,0,1,1,1,1,0,1])
  end

  it 'rejects invalid initialize' do
    expect{BooleanFunction.new(1)}.to raise_error
    expect{BooleanFunction.new([1,0,3,0])}.to raise_error
    expect{BooleanFunction.new([1,0,1])}.to raise_error
    expect{BooleanFunction.new('1030')}.to raise_error
    expect{BooleanFunction.new('101')}.to raise_error
  end

  def test_f(array)
    array[0]*array[1]
  end

  it '#initialize' do    
    f = BooleanFunction.new([1,0,1,0])
    expect(f.n).to eq 2
    expect(f.array).to eq [1,0,1,0]

    f = BooleanFunction.new('1010')
    expect(f.n).to eq 2
    expect(f.array).to eq [1,0,1,0]

    f = BooleanFunction.new(method(:test_f), 2)
    expect(f.n).to eq 2
    expect(f.array).to eq [0,0,0,1]
  end

  it '#to_rational_digit' do
    expect(BooleanFunction.new('1010').to_rational_digit).to eq [-1,1,-1,1]
  end

  it '#fourier_transform_1' do
    expect(@test.fourier_transform_1).to eq [6, 0, 0, 2, 0, 2, -2, 0]
  end

  it '#fourier_transform_2' do
    expect(@test.fourier_transform_2).to eq [-4, 0, 0, -4, 0, -4, 4, 0]
  end

  it '#normal_fourier_transform_1' do
    expect(@test.normal_fourier_transform_1).to eq [0.75, 0.0, 0.0, 0.25, 0.0, 0.25, -0.25, 0.0]
  end

  it '#normal_fourier_transform_2' do
    expect(@test.normal_fourier_transform_2).to eq [-0.5, 0.0, 0.0, -0.5, 0.0, -0.5, 0.5, 0.0]
  end

  it '#power_spectrum' do    
    expect(@test.power_spectrum).to eq [16, 0, 0, 16, 0, 16, 16, 0]
  end

  it '#auto_correlation' do    
    expect(@test.auto_correlation).to eq [8.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 8.0]
  end

  it '#*' do
    f1 = BooleanFunction.new('0001')
    f2 = BooleanFunction.new('0011')
    expect((f1*f2).array).to eq [0,0,0,1]
  end

  it '#+' do
    f1 = BooleanFunction.new('0001')
    f2 = BooleanFunction.new('0011')
    expect((f1+f2).array).to eq [0,0,1,0]
  end

  it '#^' do
    f1 = BooleanFunction.new('0001')
    f2 = BooleanFunction.new('0011')
    expect((f1^f2).array).to eq [0,0,1,0]
  end

  it '#|' do
    f1 = BooleanFunction.new('0001')
    f2 = BooleanFunction.new('0011')
    expect((f1|f2).array).to eq [0,0,1,1]
  end

  it '#&' do
    f1 = BooleanFunction.new('0001')
    f2 = BooleanFunction.new('0011')
    expect((f1&f2).array).to eq [0,0,0,1]
  end

  it '#n' do
    expect(BooleanFunction.n(2).array).to eq [0,0,0,0]
  end

  it '#e' do
    expect(BooleanFunction.e(2).array).to eq [1,1,1,1]
  end
end
