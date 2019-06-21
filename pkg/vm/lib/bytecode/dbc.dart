// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

/// Dart kernel bytecode instructions (described in runtime/vm/constants_kbc.h).

library vm.bytecode.dbc;

/// Version of bytecode format, produced by default.
/// Before bumping current bytecode version format, make sure that
/// all users have switched to a VM which is able to consume new
/// version of bytecode.
const int currentBytecodeFormatVersion = 11;

/// Version of experimental / bleeding edge bytecode format.
/// Produced by bytecode generator when --use-future-bytecode-format
/// option is enabled.
const int futureBytecodeFormatVersion = currentBytecodeFormatVersion + 1;

enum Opcode {
  // Old instructions, used before bytecode v7.
  // TODO(alexmarkov): remove

  kTrap_Old,

  // Prologue and stack management.
  kEntry_Old,
  kEntryFixed_Old,
  kEntryOptional_Old,
  kLoadConstant_Old,
  kFrame_Old,
  kCheckFunctionTypeArgs_Old,
  kCheckStack_Old,

  // Object allocation.
  kAllocate_Old,
  kAllocateT_Old,
  kCreateArrayTOS_Old,

  // Context allocation and access.
  kAllocateContext_Old,
  kCloneContext_Old,
  kLoadContextParent_Old,
  kStoreContextParent_Old,
  kLoadContextVar_Old,
  kStoreContextVar_Old,

  // Constants.
  kPushConstant_Old,
  kPushNull_Old,
  kPushTrue_Old,
  kPushFalse_Old,
  kPushInt_Old,

  // Locals and expression stack.
  kDrop1_Old,
  kPush_Old,
  kPopLocal_Old,
  kStoreLocal_Old,

  // Instance fields and arrays.
  kLoadFieldTOS_Old,
  kStoreFieldTOS_Old,
  kStoreIndexedTOS_Old,

  // Static fields.
  kPushStatic_Old,
  kStoreStaticTOS_Old,

  // Jumps.
  kJump_Old,
  kJumpIfNoAsserts_Old,
  kJumpIfNotZeroTypeArgs_Old,
  kJumpIfEqStrict_Old,
  kJumpIfNeStrict_Old,
  kJumpIfTrue_Old,
  kJumpIfFalse_Old,
  kJumpIfNull_Old,
  kJumpIfNotNull_Old,

  // Calls.
  kUnused00_Old,
  kInterfaceCall_Old,
  kDynamicCall_Old,
  kNativeCall_Old,
  kReturnTOS_Old,

  // Types and type checks.
  kAssertAssignable_Old,
  kAssertBoolean_Old,
  kAssertSubtype_Old,
  kLoadTypeArgumentsField_Old,
  kInstantiateType_Old,
  kInstantiateTypeArgumentsTOS_Old,

  // Exception handling.
  kThrow_Old,
  kMoveSpecial_Old,
  kSetFrame_Old,

  // Bool operations.
  kBooleanNegateTOS_Old,

  // Null operations.
  kEqualsNull_Old,

  // Int operations.
  kNegateInt_Old,
  kAddInt_Old,
  kSubInt_Old,
  kMulInt_Old,
  kTruncDivInt_Old,
  kModInt_Old,
  kBitAndInt_Old,
  kBitOrInt_Old,
  kBitXorInt_Old,
  kShlInt_Old,
  kShrInt_Old,
  kCompareIntEq_Old,
  kCompareIntGt_Old,
  kCompareIntLt_Old,
  kCompareIntGe_Old,
  kCompareIntLe_Old,

  kDirectCall_Old,

  kAllocateClosure_Old,

  kUncheckedInterfaceCall_Old,

  // Double operations.
  kNegateDouble_Old,
  kAddDouble_Old,
  kSubDouble_Old,
  kMulDouble_Old,
  kDivDouble_Old,
  kCompareDoubleEq_Old,
  kCompareDoubleGt_Old,
  kCompareDoubleLt_Old,
  kCompareDoubleGe_Old,
  kCompareDoubleLe_Old,

  // Bytecode instructions since bytecode format v7:

  kTrap,

  // Prologue and stack management.
  kEntry,
  kEntry_Wide,
  kEntryFixed,
  kEntryFixed_Wide,
  kEntryOptional,
  kUnused00, // Reserved for EntryNoLocals.
  kLoadConstant,
  kLoadConstant_Wide,
  kFrame,
  kFrame_Wide,
  kCheckFunctionTypeArgs,
  kCheckFunctionTypeArgs_Wide,
  kCheckStack,
  kUnused01,
  kUnused02, // Reserved for CheckParameterTypes
  kUnused03, // Reserved for CheckParameterTypes_Wide

  // Object allocation.
  kAllocate,
  kAllocate_Wide,
  kAllocateT,
  kCreateArrayTOS,
  kAllocateClosure,
  kAllocateClosure_Wide,

  // Context allocation and access.
  kAllocateContext,
  kAllocateContext_Wide,
  kCloneContext,
  kCloneContext_Wide,
  kLoadContextParent,
  kStoreContextParent,
  kLoadContextVar,
  kLoadContextVar_Wide,
  kUnused04, // Reserved for LoadContextVar0
  kUnused05,
  kStoreContextVar,
  kStoreContextVar_Wide,

  // Constants.
  kPushConstant,
  kPushConstant_Wide,
  kUnused06, // Reserved for PushConstant0
  kUnused07,
  kPushTrue,
  kPushFalse,
  kPushInt,
  kPushInt_Wide,
  kUnused08, // Reserved for PushInt0
  kUnused09, // Reserved for PushInt1
  kUnused10, // Reserved for PushInt2
  kUnused11,
  kPushNull,

  // Locals and expression stack.
  kDrop1,
  kPush,
  kPush_Wide,
  kUnused12, // Reserved for PushLocal0
  kUnused13, // Reserved for PushLocal1
  kUnused14, // Reserved for PushLocal2
  kUnused15, // Reserved for PushLocal3
  kUnused16, // Reserved for PushParamLast0
  kUnused17, // Reserved for PushParamLast1
  kPopLocal,
  kPopLocal_Wide,
  kUnused18, // Reserved for PopLocal0
  kUnused19,
  kStoreLocal,
  kStoreLocal_Wide,

  // Instance fields and arrays.
  kLoadFieldTOS,
  kLoadFieldTOS_Wide,
  kStoreFieldTOS,
  kStoreFieldTOS_Wide,
  kStoreIndexedTOS,
  kUnused20,

  // Static fields.
  kPushStatic,
  kPushStatic_Wide,
  kStoreStaticTOS,
  kStoreStaticTOS_Wide,

  // Jumps.
  kJump,
  kJump_Wide,
  kJumpIfNoAsserts,
  kJumpIfNoAsserts_Wide,
  kJumpIfNotZeroTypeArgs,
  kJumpIfNotZeroTypeArgs_Wide,
  kJumpIfEqStrict,
  kJumpIfEqStrict_Wide,
  kJumpIfNeStrict,
  kJumpIfNeStrict_Wide,
  kJumpIfTrue,
  kJumpIfTrue_Wide,
  kJumpIfFalse,
  kJumpIfFalse_Wide,
  kJumpIfNull,
  kJumpIfNull_Wide,
  kJumpIfNotNull,
  kJumpIfNotNull_Wide,

  // Calls.
  kDirectCall,
  kDirectCall_Wide,
  kUnused21, // Reserved for DirectCall1
  kUnused22, // Reserved for DirectCall1_Wide
  kInterfaceCall,
  kInterfaceCall_Wide,
  kUnused23, // Reserved for InterfaceCall1
  kUnused24, // Reserved for InterfaceCall1_Wide
  kUnused25, // Reserved for InterfaceCall2
  kUnused26, // Reserved for InterfaceCall2_Wide
  kUnused27, // Reserved for InterfaceCall3
  kUnused28, // Reserved for InterfaceCall3_Wide
  kUncheckedInterfaceCall,
  kUncheckedInterfaceCall_Wide,
  kDynamicCall,
  kDynamicCall_Wide,
  kNativeCall,
  kNativeCall_Wide,
  kReturnTOS,
  kUnused29,

  // Types and type checks.
  kAssertAssignable,
  kAssertAssignable_Wide,
  kUnused30, // Reserved for AsSimpleType
  kUnused31, // Reserved for AsSimpleType_Wide
  kAssertBoolean,
  kAssertSubtype,
  kLoadTypeArgumentsField,
  kLoadTypeArgumentsField_Wide,
  kInstantiateType,
  kInstantiateType_Wide,
  kInstantiateTypeArgumentsTOS,
  kInstantiateTypeArgumentsTOS_Wide,
  kUnused32, // Reserved for IsType
  kUnused33, // Reserved for IsType_Wide
  kUnused34, // Reserved for IsSimpleType
  kUnused35, // Reserved for IsSimpleType_Wide

  // Exception handling.
  kThrow,
  kSetFrame,
  kMoveSpecial,
  kMoveSpecial_Wide,

  // Bool operations.
  kBooleanNegateTOS,

  // Null operations.
  kEqualsNull,
  kUnused36, // Reserved for CheckNull
  kUnused37, // Reserved for CheckNull_Wide

  // Int operations.
  kNegateInt,
  kAddInt,
  kSubInt,
  kMulInt,
  kTruncDivInt,
  kModInt,
  kBitAndInt,
  kBitOrInt,
  kBitXorInt,
  kShlInt,
  kShrInt,
  kCompareIntEq,
  kCompareIntGt,
  kCompareIntLt,
  kCompareIntGe,
  kCompareIntLe,

  // Double operations.
  kNegateDouble,
  kAddDouble,
  kSubDouble,
  kMulDouble,
  kDivDouble,
  kCompareDoubleEq,
  kCompareDoubleGt,
  kCompareDoubleLt,
  kCompareDoubleGe,
  kCompareDoubleLe,
}

/// Compact variants of opcodes are always even.
/// Wide variant = opcode + kWideModifier.
const int kWideModifier = 1;

/// Opcode should fit into 1 byte.
const int kMaxOpcodes = 256;

enum Encoding {
  k0, // No operands.
  kA, // 1 operand: A = 8-bit unsigned.
  kD, // 1 operand: D = 8/32-bit unsigned.
  kX, // 1 operand: X = 8/32-bit signed.
  kT, // 1 operand: T = 8/24-bit signed.
  kAE, // 2 operands: A = 8-bit unsigned, E = 8/32-bit unsigned
  kAY, // 2 operands: A = 8-bit unsigned, Y = 8/32-bit signed
  kDF, // 2 operands: D = 8/32-bit unsigned, F = 8-bit unsigned
  kABC, // 3 operands: A, B, C - 8-bit unsigned.
}

int instructionSize(Encoding encoding, bool isWide) {
  switch (encoding) {
    case Encoding.k0:
      return 1;
    case Encoding.kA:
      return 2;
    case Encoding.kD:
      return isWide ? 5 : 2;
    case Encoding.kX:
      return isWide ? 5 : 2;
    case Encoding.kT:
      return isWide ? 4 : 2;
    case Encoding.kAE:
      return isWide ? 6 : 3;
    case Encoding.kAY:
      return isWide ? 6 : 3;
    case Encoding.kDF:
      return isWide ? 6 : 3;
    case Encoding.kABC:
      return 4;
  }
  throw 'Unexpected instruction encoding $encoding';
}

enum Operand {
  none, // ignored / non-existent operand
  imm, // immediate operand
  lit, // constant literal from object pool
  reg, // register (unsigned FP relative local)
  xeg, // x-register (signed FP relative local)
  tgt, // jump target relative to the PC of the current instruction
  spe, // SpecialIndex
}

class Format {
  final Encoding encoding;
  final List<Operand> operands;
  const Format(this.encoding, this.operands);
}

const Map<Opcode, Format> BytecodeFormats = const {
  Opcode.kTrap: const Format(
      Encoding.k0, const [Operand.none, Operand.none, Operand.none]),
  Opcode.kEntry: const Format(
      Encoding.kD, const [Operand.imm, Operand.none, Operand.none]),
  Opcode.kEntryFixed: const Format(
      Encoding.kAE, const [Operand.imm, Operand.imm, Operand.none]),
  Opcode.kEntryOptional: const Format(
      Encoding.kABC, const [Operand.imm, Operand.imm, Operand.imm]),
  Opcode.kLoadConstant: const Format(
      Encoding.kAE, const [Operand.reg, Operand.lit, Operand.none]),
  Opcode.kFrame: const Format(
      Encoding.kD, const [Operand.imm, Operand.none, Operand.none]),
  Opcode.kCheckFunctionTypeArgs: const Format(
      Encoding.kAE, const [Operand.imm, Operand.reg, Operand.none]),
  Opcode.kCheckStack: const Format(
      Encoding.kA, const [Operand.imm, Operand.none, Operand.none]),
  Opcode.kAllocate: const Format(
      Encoding.kD, const [Operand.lit, Operand.none, Operand.none]),
  Opcode.kAllocateT: const Format(
      Encoding.k0, const [Operand.none, Operand.none, Operand.none]),
  Opcode.kCreateArrayTOS: const Format(
      Encoding.k0, const [Operand.none, Operand.none, Operand.none]),
  Opcode.kAllocateContext: const Format(
      Encoding.kAE, const [Operand.imm, Operand.imm, Operand.none]),
  Opcode.kCloneContext: const Format(
      Encoding.kAE, const [Operand.imm, Operand.imm, Operand.none]),
  Opcode.kLoadContextParent: const Format(
      Encoding.k0, const [Operand.none, Operand.none, Operand.none]),
  Opcode.kStoreContextParent: const Format(
      Encoding.k0, const [Operand.none, Operand.none, Operand.none]),
  Opcode.kLoadContextVar: const Format(
      Encoding.kAE, const [Operand.imm, Operand.imm, Operand.none]),
  Opcode.kStoreContextVar: const Format(
      Encoding.kAE, const [Operand.imm, Operand.imm, Operand.none]),
  Opcode.kPushConstant: const Format(
      Encoding.kD, const [Operand.lit, Operand.none, Operand.none]),
  Opcode.kPushNull: const Format(
      Encoding.k0, const [Operand.none, Operand.none, Operand.none]),
  Opcode.kPushTrue: const Format(
      Encoding.k0, const [Operand.none, Operand.none, Operand.none]),
  Opcode.kPushFalse: const Format(
      Encoding.k0, const [Operand.none, Operand.none, Operand.none]),
  Opcode.kPushInt: const Format(
      Encoding.kX, const [Operand.imm, Operand.none, Operand.none]),
  Opcode.kDrop1: const Format(
      Encoding.k0, const [Operand.none, Operand.none, Operand.none]),
  Opcode.kPush: const Format(
      Encoding.kX, const [Operand.xeg, Operand.none, Operand.none]),
  Opcode.kPopLocal: const Format(
      Encoding.kX, const [Operand.xeg, Operand.none, Operand.none]),
  Opcode.kStoreLocal: const Format(
      Encoding.kX, const [Operand.xeg, Operand.none, Operand.none]),
  Opcode.kLoadFieldTOS: const Format(
      Encoding.kD, const [Operand.lit, Operand.none, Operand.none]),
  Opcode.kStoreFieldTOS: const Format(
      Encoding.kD, const [Operand.lit, Operand.none, Operand.none]),
  Opcode.kStoreIndexedTOS: const Format(
      Encoding.k0, const [Operand.none, Operand.none, Operand.none]),
  Opcode.kPushStatic: const Format(
      Encoding.kD, const [Operand.lit, Operand.none, Operand.none]),
  Opcode.kStoreStaticTOS: const Format(
      Encoding.kD, const [Operand.lit, Operand.none, Operand.none]),
  Opcode.kJump: const Format(
      Encoding.kT, const [Operand.tgt, Operand.none, Operand.none]),
  Opcode.kJumpIfNoAsserts: const Format(
      Encoding.kT, const [Operand.tgt, Operand.none, Operand.none]),
  Opcode.kJumpIfNotZeroTypeArgs: const Format(
      Encoding.kT, const [Operand.tgt, Operand.none, Operand.none]),
  Opcode.kJumpIfEqStrict: const Format(
      Encoding.kT, const [Operand.tgt, Operand.none, Operand.none]),
  Opcode.kJumpIfNeStrict: const Format(
      Encoding.kT, const [Operand.tgt, Operand.none, Operand.none]),
  Opcode.kJumpIfTrue: const Format(
      Encoding.kT, const [Operand.tgt, Operand.none, Operand.none]),
  Opcode.kJumpIfFalse: const Format(
      Encoding.kT, const [Operand.tgt, Operand.none, Operand.none]),
  Opcode.kJumpIfNull: const Format(
      Encoding.kT, const [Operand.tgt, Operand.none, Operand.none]),
  Opcode.kJumpIfNotNull: const Format(
      Encoding.kT, const [Operand.tgt, Operand.none, Operand.none]),
  Opcode.kInterfaceCall: const Format(
      Encoding.kDF, const [Operand.lit, Operand.imm, Operand.none]),
  Opcode.kDynamicCall: const Format(
      Encoding.kDF, const [Operand.lit, Operand.imm, Operand.none]),
  Opcode.kNativeCall: const Format(
      Encoding.kD, const [Operand.lit, Operand.none, Operand.none]),
  Opcode.kReturnTOS: const Format(
      Encoding.k0, const [Operand.none, Operand.none, Operand.none]),
  Opcode.kAssertAssignable: const Format(
      Encoding.kAE, const [Operand.imm, Operand.lit, Operand.none]),
  Opcode.kAssertBoolean: const Format(
      Encoding.kA, const [Operand.imm, Operand.none, Operand.none]),
  Opcode.kAssertSubtype: const Format(
      Encoding.k0, const [Operand.none, Operand.none, Operand.none]),
  Opcode.kLoadTypeArgumentsField: const Format(
      Encoding.kD, const [Operand.lit, Operand.none, Operand.none]),
  Opcode.kInstantiateType: const Format(
      Encoding.kD, const [Operand.lit, Operand.none, Operand.none]),
  Opcode.kInstantiateTypeArgumentsTOS: const Format(
      Encoding.kAE, const [Operand.imm, Operand.lit, Operand.none]),
  Opcode.kThrow: const Format(
      Encoding.kA, const [Operand.imm, Operand.none, Operand.none]),
  Opcode.kMoveSpecial: const Format(
      Encoding.kAY, const [Operand.spe, Operand.xeg, Operand.none]),
  Opcode.kSetFrame: const Format(
      Encoding.kA, const [Operand.imm, Operand.none, Operand.none]),
  Opcode.kBooleanNegateTOS: const Format(
      Encoding.k0, const [Operand.none, Operand.none, Operand.none]),
  Opcode.kEqualsNull: const Format(
      Encoding.k0, const [Operand.none, Operand.none, Operand.none]),
  Opcode.kNegateInt: const Format(
      Encoding.k0, const [Operand.none, Operand.none, Operand.none]),
  Opcode.kAddInt: const Format(
      Encoding.k0, const [Operand.none, Operand.none, Operand.none]),
  Opcode.kSubInt: const Format(
      Encoding.k0, const [Operand.none, Operand.none, Operand.none]),
  Opcode.kMulInt: const Format(
      Encoding.k0, const [Operand.none, Operand.none, Operand.none]),
  Opcode.kTruncDivInt: const Format(
      Encoding.k0, const [Operand.none, Operand.none, Operand.none]),
  Opcode.kModInt: const Format(
      Encoding.k0, const [Operand.none, Operand.none, Operand.none]),
  Opcode.kBitAndInt: const Format(
      Encoding.k0, const [Operand.none, Operand.none, Operand.none]),
  Opcode.kBitOrInt: const Format(
      Encoding.k0, const [Operand.none, Operand.none, Operand.none]),
  Opcode.kBitXorInt: const Format(
      Encoding.k0, const [Operand.none, Operand.none, Operand.none]),
  Opcode.kShlInt: const Format(
      Encoding.k0, const [Operand.none, Operand.none, Operand.none]),
  Opcode.kShrInt: const Format(
      Encoding.k0, const [Operand.none, Operand.none, Operand.none]),
  Opcode.kCompareIntEq: const Format(
      Encoding.k0, const [Operand.none, Operand.none, Operand.none]),
  Opcode.kCompareIntGt: const Format(
      Encoding.k0, const [Operand.none, Operand.none, Operand.none]),
  Opcode.kCompareIntLt: const Format(
      Encoding.k0, const [Operand.none, Operand.none, Operand.none]),
  Opcode.kCompareIntGe: const Format(
      Encoding.k0, const [Operand.none, Operand.none, Operand.none]),
  Opcode.kCompareIntLe: const Format(
      Encoding.k0, const [Operand.none, Operand.none, Operand.none]),
  Opcode.kDirectCall: const Format(
      Encoding.kDF, const [Operand.lit, Operand.imm, Operand.none]),
  Opcode.kAllocateClosure: const Format(
      Encoding.kD, const [Operand.lit, Operand.none, Operand.none]),
  Opcode.kUncheckedInterfaceCall: const Format(
      Encoding.kDF, const [Operand.lit, Operand.imm, Operand.none]),
  Opcode.kNegateDouble: const Format(
      Encoding.k0, const [Operand.none, Operand.none, Operand.none]),
  Opcode.kAddDouble: const Format(
      Encoding.k0, const [Operand.none, Operand.none, Operand.none]),
  Opcode.kSubDouble: const Format(
      Encoding.k0, const [Operand.none, Operand.none, Operand.none]),
  Opcode.kMulDouble: const Format(
      Encoding.k0, const [Operand.none, Operand.none, Operand.none]),
  Opcode.kDivDouble: const Format(
      Encoding.k0, const [Operand.none, Operand.none, Operand.none]),
  Opcode.kCompareDoubleEq: const Format(
      Encoding.k0, const [Operand.none, Operand.none, Operand.none]),
  Opcode.kCompareDoubleGt: const Format(
      Encoding.k0, const [Operand.none, Operand.none, Operand.none]),
  Opcode.kCompareDoubleLt: const Format(
      Encoding.k0, const [Operand.none, Operand.none, Operand.none]),
  Opcode.kCompareDoubleGe: const Format(
      Encoding.k0, const [Operand.none, Operand.none, Operand.none]),
  Opcode.kCompareDoubleLe: const Format(
      Encoding.k0, const [Operand.none, Operand.none, Operand.none]),
};

// Should match constant in runtime/vm/stack_frame_dbc.h.
const int kParamEndSlotFromFp = 4;

enum SpecialIndex {
  exception,
  stackTrace,
}

/// Returns [true] if there is a wide variant for the given opcode.
bool hasWideVariant(Opcode opcode) {
  final encoding = BytecodeFormats[opcode].encoding;
  switch (encoding) {
    case Encoding.k0:
    case Encoding.kA:
    case Encoding.kABC:
      return false;
    case Encoding.kD:
    case Encoding.kX:
    case Encoding.kT:
    case Encoding.kAE:
    case Encoding.kAY:
    case Encoding.kDF:
      return true;
  }
  throw 'Unexpected instruction encoding $encoding';
}

bool isWideOpcode(Opcode opcode) {
  return (BytecodeFormats[opcode] == null) &&
      hasWideVariant(Opcode.values[opcode.index - kWideModifier]);
}

Opcode fromWideOpcode(Opcode opcode) {
  assert(isWideOpcode(opcode));
  return Opcode.values[opcode.index - kWideModifier];
}

void verifyBytecodeInstructionDeclarations() {
  const String kWideSuffix = '_Wide';
  for (Opcode opcode in Opcode.values) {
    final format = BytecodeFormats[opcode];
    if (opcode.toString().endsWith(kWideSuffix)) {
      if (format != null) {
        throw 'Bytecode format should not be defined for wide opcode $opcode.';
      }
      final Opcode compact = Opcode.values[opcode.index - kWideModifier];
      if (compact.toString() + kWideSuffix != opcode.toString()) {
        throw 'Wide opcode $opcode should immediately follow its compact opcode (previous opcode is $compact).';
      }
      if (!hasWideVariant(compact)) {
        throw 'Wide opcode $opcode should not be defined for opcode $compact with encoding ${BytecodeFormats[compact].encoding}.';
      }
    }
    if (format == null) {
      continue;
    }
    if (hasWideVariant(opcode)) {
      if (Opcode.values[opcode.index + kWideModifier].toString() !=
          opcode.toString() + kWideSuffix) {
        throw 'Opcode $opcode$kWideSuffix should immedialy follow $opcode.';
      }
      if (opcode.index.isOdd) {
        throw 'Opcode $opcode (${format.encoding}) has a wide variant and should be even';
      }
    }
  }
  if (Opcode.values.length > kMaxOpcodes) {
    throw 'Too many opcodes';
  }
}

bool isJump(Opcode opcode) => BytecodeFormats[opcode].encoding == Encoding.kT;

bool isThrow(Opcode opcode) => opcode == Opcode.kThrow;

bool isCall(Opcode opcode) {
  switch (opcode) {
    case Opcode.kDirectCall:
    case Opcode.kInterfaceCall:
    case Opcode.kUncheckedInterfaceCall:
    case Opcode.kDynamicCall:
    case Opcode.kNativeCall:
      return true;
    default:
      return false;
  }
}

bool isReturn(Opcode opcode) => opcode == Opcode.kReturnTOS;

bool isControlFlow(Opcode opcode) =>
    isJump(opcode) || isThrow(opcode) || isCall(opcode) || isReturn(opcode);

bool isPush(Opcode opcode) {
  switch (opcode) {
    case Opcode.kPush:
    case Opcode.kPushConstant:
    case Opcode.kPushNull:
    case Opcode.kPushTrue:
    case Opcode.kPushFalse:
    case Opcode.kPushInt:
    case Opcode.kPushStatic:
      return true;
    default:
      return false;
  }
}

// Bytecode instructions reference constant pool indices using
// unsigned 32-bit operands.
const int constantPoolIndexLimit = 1 << 32;

// Local variables are referenced using 32-bit signed operands.
const int localVariableIndexLimit = 1 << 31;

// Captured variables are referenced using 32-bit unsigned operands.
const int capturedVariableIndexLimit = 1 << 32;

// Context IDs are referenced using 8-bit unsigned operands.
const int contextIdLimit = 1 << 8;

// Base class for exceptions thrown when certain limit of bytecode
// format is exceeded.
abstract class BytecodeLimitExceededException {}