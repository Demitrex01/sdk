var cascade;
(function (cascade) {
  'use strict';
  class A extends dart.Object {
    A() {
      this.x = null;
    }
  }

  // Function test_closure_with_mutate: () → void
  function test_closure_with_mutate() {
    let a = new A();
    a.x = () => {
      core.print("hi");
      a = null;
    };
    ((_) => {
      dart.dinvoke(_, "x");
      dart.dinvoke(_, "x");
    })(a);
    core.print(a);
  }

  // Function test_closure_without_mutate: () → void
  function test_closure_without_mutate() {
    let a = new A();
    a.x = () => {
      core.print(a);
    };
    dart.dinvoke(a, "x");
    dart.dinvoke(a, "x");
    core.print(a);
  }

  // Function test_mutate_inside_cascade: () → void
  function test_mutate_inside_cascade() {
    let a = null;
    a = ((_) => {
      _.x = (a = null);
      _.x = (a = null);
      return _;
    })(new A());
    core.print(a);
  }

  // Function test_mutate_outside_cascade: () → void
  function test_mutate_outside_cascade() {
    let a = null, b = null;
    a = new A();
    dart.dput(a, "x", (b = null));
    dart.dput(a, "x", (b = null));
    a = null;
    core.print(a);
  }

  // Function test_VariableDeclaration_single: () → void
  function test_VariableDeclaration_single() {
    let a = new List.from([]);
    dart.dput(a, "length", 2);
    a.add(42);
    core.print(a);
  }

  // Function test_VariableDeclaration_last: () → void
  function test_VariableDeclaration_last() {
    let a = 42, b = new List.from([]);
    dart.dput(b, "length", 2);
    b.add(a);
    core.print(b);
  }

  // Function test_VariableDeclaration_first: () → void
  function test_VariableDeclaration_first() {
    let a = ((_) => {
      _.length = 2;
      _.add(3);
      return _;
    })(new List.from([])), b = 2;
    core.print(a);
  }

  // Exports:
  cascade.A = A;
  cascade.test_closure_with_mutate = test_closure_with_mutate;
  cascade.test_closure_without_mutate = test_closure_without_mutate;
  cascade.test_mutate_inside_cascade = test_mutate_inside_cascade;
  cascade.test_mutate_outside_cascade = test_mutate_outside_cascade;
  cascade.test_VariableDeclaration_single = test_VariableDeclaration_single;
  cascade.test_VariableDeclaration_last = test_VariableDeclaration_last;
  cascade.test_VariableDeclaration_first = test_VariableDeclaration_first;
})(cascade || (cascade = {}));
