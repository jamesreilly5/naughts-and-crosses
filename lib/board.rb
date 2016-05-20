require_relative './errors/invalid_move_error'

class Board
  VALID_MARKERS = %('x', 'o').freeze

  def initialize
    @board = {
      # Hash rocket over symbols because I want to use integers for grid reference
      '1' => { 'a' => ' ', 'b' => ' ', 'c' => ' ' },
      '2' => { 'a' => ' ', 'b' => ' ', 'c' => ' ' },
      '3' => { 'a' => ' ', 'b' => ' ', 'c' => ' ' }
    }
  end

  def set_position(marker, down, across)
    validate_position(down, across) && validate_marker(marker)
    @board[down][across] = marker
  end

  def marker_at_position(down, across)
    validate_position(down, across)
    @board[down][across]
  end

  # rubocop:disable AbcSize
  def report
    %(
        a   b   c
       ___________
    1 | #{@board['1']['a']} | #{@board['1']['b']} | #{@board['1']['c']} |
       -----------
    2 | #{@board['2']['a']} | #{@board['2']['b']} | #{@board['2']['c']} |
       -----------
    3 | #{@board['3']['a']} | #{@board['3']['b']} | #{@board['3']['c']} |
       -----------
    )
  end
  # rubocop:enable AbcSize

  def validate_marker(marker)
    return true if VALID_MARKERS.include? marker
    raise InvalidMoveError, "Invalid marker: #{marker}"
  end

  private

  def validate_position(down, across)
    return true if @board[down].is_a?(Hash) && !@board[down][across].nil?
    raise InvalidMoveError, "Invalid position: #{down}, #{across}"
  end
end
