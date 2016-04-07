module Rounders
  module Receivers
    class Receiver
      class Config
        attr_accessor :protocol
        attr_accessor :mail_server_settings
        attr_accessor :find_options
      end

      class << self

        def create_client(config)
          retriever = parser.lookup_retriever_method(config.protocol)
          new(
            client: retriever.new(config.mail_server_settings),
            find_options: config.find_options)
        end

        def receive
          receivers.
            map(&:receive).
            flatten.
            sort { |a, b| a.date <=> b.date }
        end

        def reset
          @receiver = nil
          @receivers = nil
        end

        private

        def receivers
          [@receiver]
        end

        def parser
          ::Mail::Configuration.instance
        end
      end
    end
  end
end
