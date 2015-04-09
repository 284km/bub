require "bub/errors/base"

module Bub
  module Errors
    class NonExistentGitRepositoryError < Base
      def initialize(action_name)
        @action_name = action_name
      end

      def to_s
        abort "`#{@action_name}` must be run from inside a git repository"
      end
    end
  end
end
