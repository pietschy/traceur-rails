require 'test_helper'
require 'traceur/template'
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
"use strict";
Object.defineProperties(exports, {
  default: {get: function() {
      return $__default;
    }},
  __esModule: {value: true}
});
var dep = $traceurRuntime.assertObject(require('dep')).default;
var foo = function() {
  console.log('bar');
};
var $__default = foo;
JS
    expected.lstrip!

    template = Traceur::Template.new { @source }
    template.render(@scope).must_equal expected
  end


end
