require 'test_helper'
require 'traceur-rails'
require 'execjs'

describe Traceur::Template do

Scope = Struct.new('Scope', :root_path, :logical_path)

before do
    @source = <<-JS
import dep from 'dep';

var foo = function() {
  console.log('bar');
};

export default foo;
JS
    @source.strip!
    @scope = Scope.new('', 'foo')
  end

    it 'transpiles tc files' do
    expected = <<-JS
System.register("foo", [], function() {
  "use strict";
  var __moduleName = "foo";
  var dep = $traceurRuntime.assertObject(System.get("dep")).default;
  var foo = function() {
    console.log('bar');
  };
  var $__default = foo;
  return {get default() {
      return $__default;
    }};
});
JS
    expected.lstrip!

    template = Traceur::Template.new { @source }
    template.render(@scope).must_equal expected
  end


end
