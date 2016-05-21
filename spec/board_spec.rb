require 'spec_helper'

RSpec.describe Board do
  let(:board) { Board.new }

  describe '#set_position' do
    context 'when valid positions are provided' do
      it 'sets a marker for valid down' do
        board.set_position('x', '1', 'a')
        expect(board.marker_at_position('1', 'a')).to eq 'x'
      end

      it 'sets the marker for valid across' do
        board.set_position('x', '2', 'c')
        expect(board.marker_at_position('2', 'c')).to eq 'x'
      end
    end

    context 'when invalid positions are provided' do
      it 'logs an error for invalid down' do
        expect { board.set_position('x', 'a', 'a') }.to raise_error(
          InvalidMoveError, 'Invalid position: a, a, please enter 2 arguments - down (1-3) and across (a-c)'
        )
      end

      it 'logs an error for invalid across' do
        expect { board.set_position('x', '1', 'd') }.to raise_error(
          InvalidMoveError, 'Invalid position: 1, d, please enter 2 arguments - down (1-3) and across (a-c)'
        )
      end

      it 'logs an error if the slot is already occupied' do
        board.set_position('x', '1', 'a')
        expect { board.set_position('x', '1', 'a') }.to raise_error(
          InvalidMoveError, 'This slot is already occupied, please try a different slot'
        )
      end
    end

    context 'when an invalid marker is provided' do
      it 'logs an error' do
        expect { board.set_position('y', '1', 'b') }.to raise_error(
          InvalidMoveError, 'Invalid marker: y, please choose either \'x\' or \'o\''
        )
      end
    end

    # TODO
    context 'when a slot already contains an entry'
  end

  describe '#report' do
    # rubocop:disable IndentationWidth
    let(:expected_output) do
    %(
        a   b   c
       ___________
    1 | x |   |   |
       -----------
    2 |   |   |   |
       -----------
    3 |   |   | o |
       -----------
    )
    end
    # rubocop:enable IndentationWidth
    it 'reports the state of the board in ascii art' do
      board.set_position('x', '1', 'a')
      board.set_position('o', '3', 'c')
      expect(board.report).to eq expected_output
    end
  end

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

  describe '#oppponent_marker' do
    it 'retirves the opponent marker for a given marker' do
      expect(board.opponent_marker('x')).to eq 'o'
      expect(board.opponent_marker('o')).to eq 'x'
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
end
