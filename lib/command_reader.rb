class CommandReader
  def read_input(number_of_args)
    args = []

    ARGF.each_line do |_|
      break if args.size == number_of_args
      puts 'Enter next argument...'
      args << STDIN.gets.chomp
    end
    args
  end
end
