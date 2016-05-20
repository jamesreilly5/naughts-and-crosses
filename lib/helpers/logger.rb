require 'logger'

# Singleton logger helper
module Logging
  class << self
    def logger
      @logger ||= Logger.new($stdout)
    end

    attr_writer :logger
  end

  # rubocop:disable NestedMethodDefinition
  def self.included(base)
    class << base
      def logger
        Logging.logger
      end
    end
  end
  # rubocop:enable NestedMethodDefinition

  def logger
    Logging.logger
  end
end
