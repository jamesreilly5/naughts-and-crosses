require 'spec_helper'

RSpec.describe AIPlayer do
  let(:winning_lines_array) { [%w(1 b), %w(2 c)] }
  let(:board) { double(Board, winning_lines: winning_lines_array) }
  subject { AIPlayer.new.take_turn(board, 'x') }

  before { allow(Board).to receive(:new).and_return(board) }

  context '#take_turn' do
    it 'returns the highest ranking move to win' do
      expect(subject).to eq %w(1 b)
    end
  end
end
