require "minitest/doctor/version"
require 'minitest'
require "english"

module Minitest
  module Doctor
    class Checkup < Minitest::Runnable
      def self.runnable_methods
        methods_matching(/^check_/)
      end

      def run
        result = self.send(self.name)
        self.failures << result unless result.nil?
        self # per contract
      end
    end

    class CheckupReporter < Minitest::Reporter
      SEP = $INPUT_RECORD_SEPARATOR

      attr_accessor :results

      def initialize(io = $stdout, options = {})
        super
        self.results = []
      end

      def record(result)
        super
        results << result
      end

      def report
        io.puts formatted(results)
      end

      private

      def formatted(results)
        messages = results.flat_map(&:failures)
        messages.map! do |msg|
          msg.indent(4).gsub(/\A\W{3}/, "[!]")
        end
        messages.join(SEP * 2)
      end
    end
  end
end

class String
  def indent(count = 2, char = " ")
    (char * count) + gsub(/(\n+)/) { $1 + (char * count) }
  end
end
