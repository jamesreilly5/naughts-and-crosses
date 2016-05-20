lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'rake/testtask'
require 'rdoc/task'
require 'rubocop/rake_task'
require 'rspec/core/rake_task'

Dir.glob('lib/tasks/*.rake').each { |r| import r }

RuboCop::RakeTask.new
RSpec::Core::RakeTask.new(:spec)

task default: [:spec, :rubocop]
