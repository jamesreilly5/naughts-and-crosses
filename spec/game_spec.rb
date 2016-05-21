require 'spec_helper'

RSpec.describe Game do
  let(:game) { Game.new }
  let(:command_reader) { double(CommandReader, read_input: ['x']) }
  let(:board) { double(Board, validate_position: true, opponent_marker: 'o') }
  let(:ai_player) { double(AIPlayer, take_turn: %W('2' 'a')) }

  describe '#run_next_rule' do
    before do
      allow(CommandReader).to receive(:new).and_return command_reader
      allow(AIPlayer).to receive(:new).and_return ai_player
      allow(Board).to receive(:new).and_return(board)
    end

    context 'when all valid inputs occur' do
      it 'runs the rules in expected order' do
        expect(command_reader).to receive(:read_input)
        expect(board).to receive(:validate_marker)
        expect(board).to receive(:opponent_marker)
        expect(board).to receive(:report)
        game.run_next_rule

        expect(command_reader).to receive(:read_input)
        expect(board).to receive(:set_position)
        expect(board).to receive(:report)
        game.run_next_rule

        expect(ai_player).to receive(:take_turn)
        expect(board).to receive(:set_position)
        expect(board).to receive(:report)
        game.run_next_rule

        expect(command_reader).to receive(:read_input)
        expect(board).to receive(:set_position)
        expect(board).to receive(:report)
        game.run_next_rule
      end
    end

    context 'for invalid moves' do
      context 'when place marker is invalid' do
        before { allow(board).to receive(:validate_marker).and_raise InvalidMoveError }
        it 'asks to place marker again on the next turn' do
          expect(board).to receive(:report)
          expect(board).to receive(:validate_marker)
          game.run_next_rule
          expect(board).to receive(:report)
          expect(board).to receive(:validate_marker)
          game.run_next_rule
        end
      end

      context 'when set position is invalid' do
        before { allow(board).to receive(:set_position).and_raise InvalidMoveError }
        it 'asks to place marker again on the next turn' do
          expect(board).to receive(:report)
          expect(board).to receive(:validate_marker)
          game.run_next_rule
          expect(board).to receive(:report)
          expect(board).to receive(:set_position)
          game.run_next_rule
          expect(board).to receive(:report)
          expect(board).to receive(:set_position)
          game.run_next_rule
        end
      end

      # TODO
      context 'when the incorrect marker is supplied'
    end
  end
end
