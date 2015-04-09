require "bub/errors/base"

module Bub
  module Errors
    class MissingActionNameArgumentError < Base
      def to_s
        abort "Missing action name argument"
      end
    end
  end
end
