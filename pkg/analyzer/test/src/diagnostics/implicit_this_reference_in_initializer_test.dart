// Copyright (c) 2019, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:analyzer/dart/analysis/features.dart';
import 'package:analyzer/src/error/codes.dart';
import 'package:analyzer/src/generated/engine.dart';
import 'package:test_reflective_loader/test_reflective_loader.dart';

import '../dart/resolution/driver_resolution.dart';

main() {
  defineReflectiveSuite(() {
    defineReflectiveTests(ImplicitThisReferenceInInitializerTest);
    defineReflectiveTests(ImplicitThisReferenceInInitializerWithNnbdTest);
  });
}

@reflectiveTest
class ImplicitThisReferenceInInitializerTest extends DriverResolutionTest {
  test_class_field_commentReference_prefixedIdentifier() async {
    await assertNoErrorsInCode(r'''
class A {
  int a = 0;
  /// foo [a.isEven] bar
  int x = 1;
}
''');
  }

  test_class_field_commentReference_simpleIdentifier() async {
    await assertNoErrorsInCode(r'''
class A {
  int a = 0;
  /// foo [a] bar
  int x = 1;
}
''');
  }

  test_constructorName() async {
    await assertNoErrorsInCode(r'''
class A {
  A.named() {}
}
class B {
  var v;
  B() : v = new A.named();
}
''');
  }

  test_field() async {
    await assertErrorsInCode(r'''
class A {
  var v;
  A() : v = f;
  var f;
}
''', [
      error(CompileTimeErrorCode.IMPLICIT_THIS_REFERENCE_IN_INITIALIZER, 31, 1),
    ]);
  }

  test_field2() async {
    await assertErrorsInCode(r'''
class A {
  final x = 0;
  final y = x;
}
''', [
      error(StrongModeCode.TOP_LEVEL_INSTANCE_GETTER, 37, 1),
      error(CompileTimeErrorCode.IMPLICIT_THIS_REFERENCE_IN_INITIALIZER, 37, 1),
    ]);
  }

  test_invocation() async {
    await assertErrorsInCode(r'''
class A {
  var v;
  A() : v = f();
  f() {}
}
''', [
      error(CompileTimeErrorCode.IMPLICIT_THIS_REFERENCE_IN_INITIALIZER, 31, 1),
    ]);
  }

  test_invocationInStatic() async {
    await assertErrorsInCode(r'''
class A {
  static var F = m();
  int m() => 0;
}
''', [
      error(CompileTimeErrorCode.IMPLICIT_THIS_REFERENCE_IN_INITIALIZER, 27, 1),
    ]);
  }

  test_isInInstanceVariableInitializer_restored() async {
    // If ErrorVerifier._isInInstanceVariableInitializer is not properly
    // restored on exit from visitVariableDeclaration, the error at (1)
    // won't be detected.
    await assertErrorsInCode(r'''
class Foo {
  var bar;
  Map foo = {
    'bar': () {
        var _bar;
    },
    'bop': _foo // (1)
  };
  _foo() {
  }
}
''', [
      error(HintCode.UNUSED_LOCAL_VARIABLE, 65, 4),
      error(CompileTimeErrorCode.IMPLICIT_THIS_REFERENCE_IN_INITIALIZER, 89, 4),
    ]);
  }

  test_prefixedIdentifier() async {
    await assertNoErrorsInCode(r'''
class A {
  var f;
}
class B {
  var v;
  B(A a) : v = a.f;
}
''');
  }

  test_qualifiedMethodInvocation() async {
    await assertNoErrorsInCode(r'''
class A {
  f() {}
}
class B {
  var v;
  B() : v = new A().f();
}
''');
  }

  test_qualifiedPropertyAccess() async {
    await assertNoErrorsInCode(r'''
class A {
  var f;
}
class B {
  var v;
  B() : v = new A().f;
}
''');
  }

  test_redirectingConstructorInvocation() async {
    await assertErrorsInCode(r'''
class A {
  A(p) {}
  A.named() : this(f);
  var f;
}
''', [
      error(CompileTimeErrorCode.IMPLICIT_THIS_REFERENCE_IN_INITIALIZER, 39, 1),
    ]);
  }

  test_staticField_thisClass() async {
    await assertNoErrorsInCode(r'''
class A {
  var v;
  A() : v = f;
  static var f;
}
''');
  }

  test_staticGetter() async {
    await assertNoErrorsInCode(r'''
class A {
  var v;
  A() : v = f;
  static get f => 42;
}
''');
  }

  test_staticMethod() async {
    await assertNoErrorsInCode(r'''
class A {
  var v;
  A() : v = f();
  static f() => 42;
}
''');
  }

  test_superConstructorInvocation() async {
    await assertErrorsInCode(r'''
class A {
  A(p) {}
}
class B extends A {
  B() : super(f);
  var f;
}
''', [
      error(CompileTimeErrorCode.IMPLICIT_THIS_REFERENCE_IN_INITIALIZER, 56, 1),
    ]);
  }

  test_topLevelField() async {
    await assertNoErrorsInCode(r'''
class A {
  var v;
  A() : v = f;
}
var f = 42;
''');
  }

  test_topLevelFunction() async {
    await assertNoErrorsInCode(r'''
class A {
  var v;
  A() : v = f();
}
f() => 42;
''');
  }

  test_topLevelGetter() async {
    await assertNoErrorsInCode(r'''
class A {
  var v;
  A() : v = f;
}
get f => 42;
''');
  }

  test_typeParameter() async {
    await assertNoErrorsInCode(r'''
class A<T> {
  var v;
  A(p) : v = (p is T);
}
''');
  }
}

@reflectiveTest
class ImplicitThisReferenceInInitializerWithNnbdTest
    extends ImplicitThisReferenceInInitializerTest {
  @override
  AnalysisOptionsImpl get analysisOptions => AnalysisOptionsImpl()
    ..contextFeatures = FeatureSet.forTesting(
        sdkVersion: '2.3.0', additionalFeatures: [Feature.non_nullable]);

  test_class_field_late_invokeInstanceMethod() async {
    await assertNoErrorsInCode(r'''
class A {
  late int x = foo();
  int foo() => 0;
}
''');
  }

  test_class_field_late_invokeStaticMethod() async {
    await assertNoErrorsInCode(r'''
class A {
  late int x = foo();
  static int foo() => 0;
}
''');
  }

  test_class_field_late_readInstanceField() async {
    await assertNoErrorsInCode(r'''
class A {
  int a = 0;
  late int x = a;
}
''');
  }

  test_class_field_late_readStaticField() async {
    await assertNoErrorsInCode(r'''
class A {
  static int a = 0;
  late int x = a;
}
''');
  }

  test_mixin_field_late_readInstanceField() async {
    await assertNoErrorsInCode(r'''
mixin M {
  int a = 0;
  late int x = a;
}
''');
  }
}
