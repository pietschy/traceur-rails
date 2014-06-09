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

export default = foo;
JS
    @source.rstrip!
    @scope = Scope.new('', 'foo')
  end

    it 'transpiles tc into amd by default' do
    expected = <<-JS
define("foo",
  ["dep","exports"],
  function(__dependency1__, __exports__) {
    "use strict";
    var dep = __dependency1__["default"];

    var foo = function() {
      console.log('bar');
    };

    __exports__["default"] = foo;
  });
JS
    expected.rstrip!

    template = Traceur::Template.new { @source }
    template.render(@scope).must_equal expected
  end


end
