; ModuleID = '/home/david/src/c-semantics/tests/gcc-torture/991202-2.c'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @f1() nounwind uwtable {
entry:
  %x = alloca i64, align 8
  %y = alloca i64, align 8
  store i64 1, i64* %y, align 8
  %0 = load i64* %y, align 8
  %mul = mul i64 %0, 8192
  %sub = sub i64 %mul, 216
  %rem = urem i64 %sub, 16
  store i64 %rem, i64* %x, align 8
  %1 = load i64* %x, align 8
  %conv = trunc i64 %1 to i32
  ret i32 %conv
}

define i32 @main() nounwind uwtable {
entry:
  %retval = alloca i32, align 4
  store i32 0, i32* %retval
  %call = call i32 @f1()
  %cmp = icmp ne i32 %call, 8
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  call void @abort() noreturn nounwind
  unreachable

if.end:                                           ; preds = %entry
  call void @exit(i32 0) noreturn nounwind
  unreachable

return:                                           ; No predecessors!
  %0 = load i32* %retval
  ret i32 %0
}

declare void @abort() noreturn nounwind

declare void @exit(i32) noreturn nounwind
