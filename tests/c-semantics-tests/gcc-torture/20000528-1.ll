; ModuleID = '/home/david/src/c-semantics/tests/gcc-torture/20000528-1.c'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@l = global i64 -2, align 8
@s = common global i16 0, align 2

define i32 @main() nounwind uwtable {
entry:
  %retval = alloca i32, align 4
  %t = alloca i64, align 8
  store i32 0, i32* %retval
  %0 = load i64* @l, align 8
  store i64 %0, i64* %t, align 8
  %1 = load i64* %t, align 8
  %conv = trunc i64 %1 to i16
  store i16 %conv, i16* @s, align 2
  %2 = load i16* @s, align 2
  %conv1 = zext i16 %2 to i32
  %cmp = icmp ne i32 %conv1, 65534
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  call void @abort() noreturn nounwind
  unreachable

if.end:                                           ; preds = %entry
  call void @exit(i32 0) noreturn nounwind
  unreachable

return:                                           ; No predecessors!
  %3 = load i32* %retval
  ret i32 %3
}

declare void @abort() noreturn nounwind

declare void @exit(i32) noreturn nounwind
