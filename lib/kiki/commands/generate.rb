module Kiki
  module Commands
    class Generate < Thor
      desc 'handler <name> [<handlers>...]', 'Generate new handler'
      def handler(name, *handlers)
        Kiki::Generators::Handler.new(name: name, handlers: handlers).generate
      end
    end
  end
end