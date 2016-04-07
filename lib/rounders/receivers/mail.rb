module Rounders
  module Receivers
    class Mail < Receiver

      DEFALUT_FIND_OPTION = {
        keys: %w(NOT SEEN)
      }.freeze
      attr_reader :client, :find_options

      def initialize(client: nil, find_options: {})
        @client = client
        @find_options = DEFALUT_FIND_OPTION.merge(find_options)
      end

      def configure
        config = Config.new
        yield config
        @client = Receiver.create_client(config)
      end

      def receive
        @client.
          find(find_options).
          map { |message| Rounders::Mail.new(message) }
      end

      class << self
        def configure
          config = Config.new
          yield config
          @receiver = create_client(config)
        end

        def create_client(config)
          retriever = parser.lookup_retriever_method(config.protocol)
          new(
            client: retriever.new(config.mail_server_settings),
            find_options: config.find_options)
        end
      end
    end
  end
end
