require_relative './helpers/logger'

class Board
  include Logging

  def initialize
    @board = {
      # Hash rocket over symbols because I want to use integers for grid reference
      '1' => { 'a' => '', 'b' => '', 'c' => '' },
      '2' => { 'a' => '', 'b' => '', 'c' => '' },
      '3' => { 'a' => '', 'b' => '', 'c' => '' }
    }
  end

  def valid_position?(down, across)
    return true if @board[down].is_a?(Hash) && !@board[down][across].nil?
    logger.error("Invalid position: #{down}, #{across}")
    false
  end
end
