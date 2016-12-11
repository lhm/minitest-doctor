module Minitest
  # This is only here to prevent running checkups as tests
  # since Minitest::Runnable registers all it's inheritants
  # TODO: see if this can be fixed in Minitest properly
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
