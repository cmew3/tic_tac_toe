require 'monkey'

describe Monkey do
    let(:monkey) {Monkey.new("monkey",:nought)}
    let(:board)  { double :board }
  it 'selects random coordinates' do
    allow(Kernel).to receive(:rand).exactly(2).times.with(3).and_return(0,0)
    expect(monkey.select_coordinate(board)).to eq({x:0, y:0})
  end

end