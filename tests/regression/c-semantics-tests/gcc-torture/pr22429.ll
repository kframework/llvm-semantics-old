; ModuleID = '/home/david/src/c-semantics/tests/gcc-torture/pr22429.c'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @f(i32 %n) nounwind uwtable {
entry:
  %retval = alloca i32, align 4
  %n.addr = alloca i32, align 4
  store i32 %n, i32* %n.addr, align 4
  %0 = load i32* %n.addr, align 4
  %cmp = icmp sle i32 -1073741824, %0
  br i1 %cmp, label %land.lhs.true, label %if.end

land.lhs.true:                                    ; preds = %entry
  %1 = load i32* %n.addr, align 4
  %cmp1 = icmp sle i32 %1, 1073741823
  br i1 %cmp1, label %if.then, label %if.end

if.then:                                          ; preds = %land.lhs.true
  store i32 1, i32* %retval
  br label %return

if.end:                                           ; preds = %land.lhs.true, %entry
  store i32 0, i32* %retval
  br label %return

return:                                           ; preds = %if.end, %if.then
  %2 = load i32* %retval
  ret i32 %2
}

define i32 @main() nounwind uwtable {
entry:
  %retval = alloca i32, align 4
  store i32 0, i32* %retval
  %call = call i32 @f(i32 1073741824)
  %tobool = icmp ne i32 %call, 0
  br i1 %tobool, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  call void @abort() noreturn nounwind
  unreachable

if.end:                                           ; preds = %entry
  ret i32 0
}

declare void @abort() noreturn nounwind
