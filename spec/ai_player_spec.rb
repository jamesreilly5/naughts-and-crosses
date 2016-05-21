require 'spec_helper'

RSpec.describe AIPlayer do
  let(:winning_lines_array) { [%w(1 b), %w(2 c)] }
  let(:board) do
    double(Board, winning_lines: winning_lines_array, opponent_marker: 'o', one_move_to_win: [])
  end
  subject { AIPlayer.new.take_turn(board, 'x') }

  before { allow(Board).to receive(:new).and_return(board) }

  context '#take_turn' do
    it 'returns the highest ranking move to win' do
      expect(subject).to eq %w(1 b)
    end
  end

  context 'when opponent is about to win' do
    before { allow(board).to receive(:one_move_to_win).and_return([%w(1 a)]) }
    it 'blocks the opponent' do
      expect(subject).to eq %w(1 a)
    end
  end
end
