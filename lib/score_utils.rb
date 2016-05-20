module ScoreUtils
  EMPTY_VALUE = ' '.freeze
  NA_SCORE = 1000
  # Go through each slot on the board and see if it can win either vertically
  # or horizontally. Results are ordered least number of moves to win.

  # Problem: This algorithm doubles up on the middle slot and potentially
  # a the same slow can have the same score vertically and horizonally so
  # that's doubling up too.
  # rubocop:disable AbcSize
  def winning_lines(marker)
    scores = []

    @board.keys.each do |down|
      @board[down].keys.each do |across|
        next if marker_at_position(down, across) == marker
        add_turns_to_win_for_slot!(scores, marker, down, across)
      end
    end
    scores.reject { |hash| hash[:score] > 3 }
          .sort_by { |hash| hash[:score] }
          .map { |hash| hash[:index] }
  end
  # rubocop:enable AbcSize

  def add_turns_to_win_for_slot!(scores, marker, down, across)
    scores << { index: [down, across], score: moves_to_win_horizontally(down, marker) }
    scores << { index: [down, across], score: moves_to_win_vertically(across, marker) }
  end

  # Give a score for the row. nil if oponent is already in the row, 3 if all
  # slots are empty, 2 if 2 slots empty and you occupy the other slot, 1 if
  # 1 slot empty and you occupy the other slot. This gives a ranking on the
  # number of moves to win.
  def moves_to_win_horizontally(down, marker)
    score = 3
    %w(a b c).each do |across|
      score = calculate_score_for_marker(score, down, across, marker)
    end
    score
  end

  # Give a score for the column. nil if oponent is already in the row, 3 if all
  # slots are empty, 2 if 2 slots empty and you occupy the other slot, 1 if
  # 1 slot empty and you occupy the other slot. This gives a ranking on the
  # number of moves to win.
  def moves_to_win_vertically(across, marker)
    score = 3
    %w(1 2 3).each do |down|
      score = calculate_score_for_marker(score, down, across, marker)
    end
    score
  end

  # Determine how to score the slot based on its content
  def calculate_score_for_marker(score, down, across, marker)
    # binding.pry
    value = marker_at_position(down, across)
    return score if value == EMPTY_VALUE
    return (score - 1) if value == marker
    NA_SCORE
  end
end
