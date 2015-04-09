require "bub/errors/base"

module Bub
  module Errors
    class UnknownActionNameError < Base
      def initialize(action_name)
        @action_name = action_name
      end

      def to_s
        abort "Unknown action name `#{@action_name}`"
      end
    end
  end
end

