require 'spec_helper'

RSpec.describe CommandReader do
  let(:command_reader) { CommandReader.new }

  context '#read_input' do
    context 'output' do
      before { allow(STDIN).to receive(:gets).and_return '1', 'a', 'test' }

      it 'returns an array of the given arguments' do
        expect(command_reader.read_input(3)).to eq %w(1 a test)
      end
    end

    context 'arguments' do
      before { allow(STDIN).to receive(:gets).and_return '1', '2', 'd', 'f', 'g' }

      it 'reads an array of the given arguments' do
        expect(command_reader.read_input(5)).to eq %w(1 2 d f g)
      end
    end
  end
end
