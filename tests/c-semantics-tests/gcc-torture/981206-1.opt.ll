; ModuleID = '/home/david/src/c-semantics/tests/gcc-torture/981206-1.c'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@x.b = internal unnamed_addr global i1 false
@y.b = internal unnamed_addr global i1 false

define void @foo() nounwind uwtable {
entry:
  store i1 true, i1* @x.b, align 1
  store i1 true, i1* @y.b, align 1
  ret void
}

define i32 @main() noreturn nounwind uwtable {
if.end:
  store i1 true, i1* @x.b, align 1
  store i1 true, i1* @y.b, align 1
  tail call void @exit(i32 0) noreturn nounwind
  unreachable
}

declare void @exit(i32) noreturn nounwind
