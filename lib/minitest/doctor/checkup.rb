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
  end
end
