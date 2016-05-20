require 'spec_helper'

RSpec.describe Board do
  let(:board) { Board.new }

  describe '#valid_position?' do
    it { expect(board.valid_position?('1', 'a')).to eq true }
    it { expect(board.valid_position?('2', 'c')).to eq true }
    it { expect(board.valid_position?('3', 'b')).to eq true }

    it { expect(board.valid_position?('-1', 'a')).to eq false }
    it { expect(board.valid_position?('1', 'd')).to eq false }
  end
end
