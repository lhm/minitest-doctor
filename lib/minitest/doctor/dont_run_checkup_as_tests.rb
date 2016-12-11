module Minitest
  module DontRunCheckupAsTests
    module ClassMethods
      def inherited(klass)
        return nil if klass.ancestors.include?(Minitest::Doctor::Checkup)
        super
      end
    end

    def self.prepended(base)
      class << base
        prepend ClassMethods
      end
    end
  end
end

Minitest::Runnable.prepend(Minitest::DontRunCheckupAsTests)
