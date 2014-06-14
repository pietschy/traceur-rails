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
