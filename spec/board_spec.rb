require 'spec_helper'

RSpec.describe Board do
  let(:board) { Board.new }
  let(:dummy_logger) { double(Logging, error: true) }

  before { allow(Logging).to receive(:logger).and_return(dummy_logger) }

  describe '#valid_position?' do
    context 'when valid positions are provided' do
      it { expect(board.valid_position?('1', 'a')).to eq true }
      it { expect(board.valid_position?('2', 'c')).to eq true }
      it { expect(board.valid_position?('3', 'b')).to eq true }
    end

    context 'when invalid positions are provided' do
      it { expect(board.valid_position?('-1', 'a')).to eq false }
      it { expect(board.valid_position?('1', 'd')).to eq false }

      it 'logs an error' do
        expect(dummy_logger).to receive(:error).with('Invalid position: a, a')
        board.valid_position?('a', 'a')
      end
    end
  end
end
