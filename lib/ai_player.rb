class AIPlayer
  def take_turn(board, marker)
    potential_moves = board.winning_lines(marker)
    opponents_moves_to_win = board.one_move_to_win(board.opponent_marker(marker))
    return opponents_moves_to_win.shift unless opponents_moves_to_win.empty?
    potential_moves.shift
  end
end
