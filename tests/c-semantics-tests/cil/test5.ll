; ModuleID = '/home/david/src/c-semantics/tests/cil/test5.c'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@.str = private unnamed_addr constant [36 x i8] c"hello world - %d args, and x is %d\0A\00", align 1

define i32 @main(i32 %argc, i8** %argv) nounwind uwtable {
entry:
  %retval = alloca i32, align 4
  %argc.addr = alloca i32, align 4
  %argv.addr = alloca i8**, align 8
  %x = alloca i32, align 4
  store i32 0, i32* %retval
  store i32 %argc, i32* %argc.addr, align 4
  store i8** %argv, i8*** %argv.addr, align 8
  store i32 2, i32* %x, align 4
  %0 = load i32* %argc.addr, align 4
  %tobool = icmp ne i32 %0, 0
  br i1 %tobool, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  %1 = load i32* %x, align 4
  %sub = sub nsw i32 0, %1
  store i32 %sub, i32* %x, align 4
  br label %if.end

if.end:                                           ; preds = %if.then, %entry
  %2 = load i32* %argc.addr, align 4
  %sub1 = sub nsw i32 0, %2
  %3 = load i32* %x, align 4
  %call = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([36 x i8]* @.str, i32 0, i32 0), i32 %sub1, i32 %3)
  ret i32 0
}

declare i32 @printf(i8*, ...)
