require 'test_helper'
require 'traceur-rails'
require 'execjs'

describe Traceur::Template do
  Scope = Struct.new('Scope', :root_path, :logical_path)

  before do
    @source = fixture('source.tc')
    @source.strip!
    @scope = Scope.new('', 'foo')
  end

  it 'transpiles tc files' do
    expected = fixture('compiled_register.js')
    expected.lstrip!

    template = Traceur::Template.new { @source }
    template.render(@scope).must_equal(expected)
  end
end
