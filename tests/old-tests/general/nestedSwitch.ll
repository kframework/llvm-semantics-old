; ModuleID = '/home/grosu/celliso2/c-semantics/tests/unitTests/nestedSwitch.c'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64"
target triple = "x86_64-unknown-linux-gnu"

@.str = private unnamed_addr constant [5 x i8] c"one\0A\00", align 1
@.str1 = private unnamed_addr constant [5 x i8] c"two\0A\00", align 1
@.str2 = private unnamed_addr constant [9 x i8] c"default\0A\00", align 1
@.str3 = private unnamed_addr constant [7 x i8] c"three\0A\00", align 1
@.str4 = private unnamed_addr constant [13 x i8] c"sneaky four\0A\00", align 1

define i32 @main() nounwind uwtable {
entry:
  %retval = alloca i32, align 4
  %inMain = alloca i32, align 4
  %i = alloca i32, align 4
  store i32 0, i32* %retval
  store i32 2, i32* %inMain, align 4
  store i32 0, i32* %i, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %tmp = load i32* %i, align 4
  %cmp = icmp slt i32 %tmp, 5
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %tmp1 = load i32* %i, align 4
  %cmp2 = icmp ne i32 %tmp1, 4
  br i1 %cmp2, label %if.then, label %if.else

if.then:                                          ; preds = %for.body
  %tmp3 = load i32* %i, align 4
  switch i32 %tmp3, label %sw.default [
    i32 1, label %sw.bb
    i32 2, label %sw.bb4
    i32 3, label %sw.bb7
  ]

sw.bb:                                            ; preds = %if.then
  %call = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.str, i32 0, i32 0))
  br label %sw.epilog

sw.bb4:                                           ; preds = %if.then
  %call5 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.str1, i32 0, i32 0))
  br label %sw.epilog

sw.default:                                       ; preds = %if.then
  %call6 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([9 x i8]* @.str2, i32 0, i32 0))
  br label %sw.epilog

sw.bb7:                                           ; preds = %if.then
  %call8 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([7 x i8]* @.str3, i32 0, i32 0))
  br label %sw.epilog

sw.epilog:                                        ; preds = %sw.bb7, %sw.default, %sw.bb4, %sw.bb
  br label %if.end

if.else:                                          ; preds = %for.body
  %call9 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str4, i32 0, i32 0))
  br label %if.end

if.end:                                           ; preds = %if.else, %sw.epilog
  br label %for.inc

for.inc:                                          ; preds = %if.end
  %tmp10 = load i32* %i, align 4
  %inc = add nsw i32 %tmp10, 1
  store i32 %inc, i32* %i, align 4
  br label %for.cond

for.end:                                          ; preds = %for.cond
  ret i32 0
}

declare i32 @printf(i8*, ...)
