require 'bundler/setup'

if defined?(M)
  require 'minitest/spec'
else
  require 'minitest/autorun'
end

class MiniTest::Spec
  class << self
    alias :context :describe
  end
end
