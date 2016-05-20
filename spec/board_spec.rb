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
        expect { board.set_position('x', 'a', 'a') }.to raise_error(InvalidMoveError, 'Invalid position: a, a')
      end

      it 'logs an error for invalid across' do
        expect { board.set_position('x', '1', 'd') }.to raise_error(InvalidMoveError, 'Invalid position: 1, d')
      end
    end

    context 'when an invalid marker is provided' do
      it 'logs an error' do
        expect { board.set_position('y', '1', 'b') }.to raise_error(InvalidMoveError, 'Invalid marker: y')
      end
    end
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
end
