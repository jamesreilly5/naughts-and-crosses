class CommandReader
  def read_input(number_of_args)
    args = []

    while true
      break if args.size == number_of_args
      puts 'Enter next argument...'
      args << STDIN.gets.chomp
    end
    args
  end
end
