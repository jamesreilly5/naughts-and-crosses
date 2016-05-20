class Board
  def initialize
    @board = {
      # Hash rocket over symbols because I want to use integers for grid reference
      '1' => { 'a' => '', 'b' => '', 'c' => '' },
      '2' => { 'a' => '', 'b' => '', 'c' => '' },
      '3' => { 'a' => '', 'b' => '', 'c' => '' }
    }
  end

  def valid_position?(down, across)
    @board[down].is_a?(Hash) && !@board[down][across].nil?
  end
end
