# naughts-and-crosses

A simple program with some basic AI that plays naughts and crosses

### Problem
Write a Ruby program that can play Noughts & Crosses with some intelligence built in. For example, the computer should be able to block winning moves. A simple text­only console interface is fine.

### Dependencies
* Ruby 2.0+
* Bundler

### Setup
```gem install bundler```

```bundle install```

### Running the game
```bundle exec rake naughts_and_crosses:play```

### Running the tests
```bundle exec rake```

### Known issues
* Game has no knowledge of diagonals being winning lines
* AI doesn't block winning moves yet
