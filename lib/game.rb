require_relative './command_reader'
require_relative './ai_player'
require_relative './board'

class Game
  @player_marker = nil
  @ai_marker = nil

  def initialize
    @rule_stack = [:choose_marker, :human_player_turn, :ai_player_turn]
    @commmand_reader = CommandReader.new
    @board = Board.new
    @ai_player = AIPlayer.new
  end

  def run_next_rule
    send(@rule_stack[0])
  rescue InvalidMoveError
    puts 'Invalid command, please try again'
  end

  private

  def choose_marker
    input_args = @commmand_reader.read_input
    # TODO: Work out where to parse this from user input, maybe tell it how many
    # args we expect and parse string accordingly command_reader throw argument
    # exception when wrong number supplied.
    @board.validate_marker(input_args[0])
    # Only need this rule once
    @rule_stack.shift
  end

  def ai_player_turn
    input_args = @ai_player.take_turn
    @board.set_position(input_args[0], input_args[1], input_args[2])
    @rule_stack.rotate!
  end

  def human_player_turn
    input_args = @commmand_reader.read_input
    @board.set_position(input_args[0], input_args[1], input_args[2])
    @rule_stack.rotate!
  end
end
