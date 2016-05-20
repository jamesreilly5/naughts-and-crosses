class AIPlayer
  def take_turn(board, marker)
    potential_moves = board.winning_lines(marker)
    potential_moves.shift
  end
end
