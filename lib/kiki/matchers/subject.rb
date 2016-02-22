module Kiki
  module Matchers
    class Subject < Kiki::Matchers::Matcher
      attr_reader :pattern

      def initialize(pattern)
        @pattern = pattern
      end

      def match(mail)
        return if mail.subject.nil?
        mail.subject.match(pattern)
      end
    end
  end
end
