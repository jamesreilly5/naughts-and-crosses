require 'spec_helper'

# Test module ScoreUtils
RSpec.describe ScoreUtils do
  let(:board) { Board.new }

  # Get a report of potential winning lines ordered by moves and grouped by marker
  describe '#winning_lines' do
    let(:expected_o_output) do
      [
        %w(2 b ), %w(3 a ), %w(1 b ), %w(2 c ), %w(1 a ), %w(1 a ), %w(3 b ), %w(3 c ),
        %w(3 c ), %w(1 b ), %w(2 b ), %w(2 c ), %w(3 a ), %w(3 b )
      ]
    end
    let(:expected_x_output) do
      [
        %w(3 a ), %w(2 b ), %w(1 b ), %w(1 c ), %w(2 c ), %w(2 a ), %w(2 b ), %w(2 c ),
        %w(1 a ), %w(3 a ), %w(1 a ), %w(1 b ), %w(1 c ), %w(2 a )
      ]
    end
    it 'reports the winning lines grouped by marker and ordered by moves' do
      board.set_position('o', '1', 'c')
      board.set_position('o', '2', 'a')
      board.set_position('x', '3', 'b')
      board.set_position('x', '3', 'c')
      expect(board.winning_lines('o')).to eq expected_o_output
      expect(board.winning_lines('x')).to eq expected_x_output
    end
  end

  describe '#winning_line?' do
    it 'return true for a winning line' do
      board.set_position('o', '1', 'a')
      board.set_position('o', '1', 'b')
      board.set_position('o', '1', 'c')
      expect(board.winning_line?('o')).to eq true
    end

    it 'return false for a winning line' do
      board.set_position('o', '1', 'a')
      board.set_position('o', '1', 'b')
      expect(board.winning_line?('o')).to eq false
    end
  end

  describe '#one_move_to_win' do
    it 'return false for a winning line' do
      board.set_position('o', '1', 'a')
      board.set_position('o', '1', 'b')
      expect(board.one_move_to_win('o')).to eq [%w(1 c)]
    end
  end
end
