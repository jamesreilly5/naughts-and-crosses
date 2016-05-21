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
    puts '='*80
    puts @board.report
    check_if_any_player_has_won
    send(@rule_stack[0])
  rescue InvalidMoveError => e
    puts "Invalid command: '#{e}'"
  end

  def game_over
    @game_over ||= false
  end

  private

  def check_if_any_player_has_won
    if @board.winning_line?(@player_marker)
      puts 'Player has won'
      @game_over = true
    elsif @board.winning_line?(@ai_marker)
      puts 'AI player has won'
      @game_over = true
    end
  end

  def choose_marker
    puts "choose your marker, either 'x' or 'o'"
    marker = @commmand_reader.read_input(1)[0]
    @board.validate_marker(marker)
    @player_marker = marker
    @ai_marker = @board.opponent_marker(marker)
    # Only need this rule once
    @rule_stack.shift
  end

  def ai_player_turn
    input_args = @ai_player.take_turn(@board, @ai_marker)
    puts "AI Player has chosen #{input_args[0]}, #{input_args[1]}"
    @board.set_position(@ai_marker, input_args[0], input_args[1])
    @rule_stack.rotate!
  end

  def human_player_turn
    puts 'Choose a location on the grid, enter 2 arguments - down (1-3) and across (a-c)'
    input_args = @commmand_reader.read_input(2)
    @board.set_position(@player_marker, input_args[0], input_args[1])
    @rule_stack.rotate!
  end
end
