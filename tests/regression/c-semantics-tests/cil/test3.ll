; ModuleID = '/home/david/src/c-semantics/tests/cil/test3.c'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@.str = private unnamed_addr constant [4 x i8] c"%d\0A\00", align 1

define i32 @f() nounwind uwtable {
entry:
  %a = alloca [20 x i32], align 16
  %arrayidx = getelementptr inbounds [20 x i32]* %a, i32 0, i64 0
  store i32 33, i32* %arrayidx, align 4
  %arrayidx1 = getelementptr inbounds [20 x i32]* %a, i32 0, i64 2
  store i32 19, i32* %arrayidx1, align 4
  %arrayidx2 = getelementptr inbounds [20 x i32]* %a, i32 0, i64 2
  %0 = load i32* %arrayidx2, align 4
  ret i32 %0
}

define i32 @main(i32 %argc, i8** %argv) nounwind uwtable {
entry:
  %retval = alloca i32, align 4
  %argc.addr = alloca i32, align 4
  %argv.addr = alloca i8**, align 8
  %zz = alloca i32, align 4
  store i32 0, i32* %retval
  store i32 %argc, i32* %argc.addr, align 4
  store i8** %argv, i8*** %argv.addr, align 8
  %call = call i32 @f()
  store i32 %call, i32* %zz, align 4
  %0 = load i32* %zz, align 4
  %call1 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str, i32 0, i32 0), i32 %0)
  ret i32 0
}

declare i32 @printf(i8*, ...)
