require_relative '../game'

namespace :naughts_and_crosses do
  desc 'Play naughts and crosses game'
  task :play do
    game = Game.new
    until game.game_over
      game.run_next_rule
    end
  end
end
