require "minitest/doctor/version"
require "minitest"
require "minitest/doctor/dont_run_checkup_as_tests"

module Minitest
  module Doctor
    class Checkup < Minitest::Runnable
      def self.runnable_methods
        methods_matching(/^check_/)
      end

      def run
        self.failures << self.send(self.name)
        self # per contract
      end
    end

    class CheckupReporter < Minitest::Reporter
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
        io.puts results.flat_map(&:failures).join("\n")
      end
    end
  end
end
