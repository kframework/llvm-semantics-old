; ModuleID = '/home/david/src/c-semantics/tests/gcc-torture/pr23604.c'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @g(i32 %i, i32 %j) nounwind uwtable {
entry:
  %retval = alloca i32, align 4
  %i.addr = alloca i32, align 4
  %j.addr = alloca i32, align 4
  store i32 %i, i32* %i.addr, align 4
  store i32 %j, i32* %j.addr, align 4
  %0 = load i32* %i.addr, align 4
  %cmp = icmp sgt i32 %0, -1
  br i1 %cmp, label %if.then, label %if.end9

if.then:                                          ; preds = %entry
  %1 = load i32* %i.addr, align 4
  %cmp1 = icmp slt i32 %1, 2
  br i1 %cmp1, label %if.then2, label %if.end8

if.then2:                                         ; preds = %if.then
  %2 = load i32* %i.addr, align 4
  %3 = load i32* %j.addr, align 4
  %cmp3 = icmp ne i32 %2, %3
  br i1 %cmp3, label %if.then4, label %if.end7

if.then4:                                         ; preds = %if.then2
  %4 = load i32* %j.addr, align 4
  %cmp5 = icmp ne i32 %4, 0
  br i1 %cmp5, label %if.then6, label %if.end

if.then6:                                         ; preds = %if.then4
  store i32 0, i32* %retval
  br label %return

if.end:                                           ; preds = %if.then4
  br label %if.end7

if.end7:                                          ; preds = %if.end, %if.then2
  br label %if.end8

if.end8:                                          ; preds = %if.end7, %if.then
  br label %if.end9

if.end9:                                          ; preds = %if.end8, %entry
  store i32 1, i32* %retval
  br label %return

return:                                           ; preds = %if.end9, %if.then6
  %5 = load i32* %retval
  ret i32 %5
}

define i32 @main() nounwind uwtable {
entry:
  %retval = alloca i32, align 4
  store i32 0, i32* %retval
  %call = call i32 @g(i32 1, i32 0)
  %tobool = icmp ne i32 %call, 0
  br i1 %tobool, label %if.end, label %if.then

if.then:                                          ; preds = %entry
  call void @abort() noreturn nounwind
  unreachable

if.end:                                           ; preds = %entry
  ret i32 0
}

declare void @abort() noreturn nounwind
