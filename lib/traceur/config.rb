module Traceur
  module Config
    class << self
      def compile_to
        @compile_to || :amd
      end

      def compile_to=(target)
        @compile_to = target
      end

      def prefix_patterns
        @prefix_patterns ||= []
      end

      def add_prefix_pattern(pattern, prefix)
        prefix_patterns << [pattern, prefix]
      end

      def lookup_prefix(path)
        _, prefix = prefix_patterns.detect {|pattern, prefix| pattern =~ path }
        prefix
      end

      def transform=(transform)
        @transform = transform
      end

      def transform
        @transform
      end

      def compiler_options
        @compiler_options ||= {}
      end
    end
  end
end
