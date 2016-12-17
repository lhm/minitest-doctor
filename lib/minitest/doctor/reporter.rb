module Minitest
  module Doctor
    class Reporter < Minitest::Reporter
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
