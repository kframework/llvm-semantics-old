; ModuleID = '/home/grosu/celliso2/c-semantics/tests/unitTests/sizeofString.ll'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64"
target triple = "x86_64-unknown-linux-gnu"

@.str = private unnamed_addr constant [16 x i8] c"sizeof(a) = %d\0A\00", align 1
@.str1 = private unnamed_addr constant [16 x i8] c"sizeof(b) = %d\0A\00", align 1
@.str2 = private unnamed_addr constant [16 x i8] c"sizeof(c) = %d\0A\00", align 1
@.str3 = private unnamed_addr constant [16 x i8] c"sizeof(d) = %d\0A\00", align 1

define i32 @main() nounwind uwtable {
entry:
  %call = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([16 x i8]* @.str, i64 0, i64 0), i64 4) nounwind
  %call1 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([16 x i8]* @.str1, i64 0, i64 0), i64 3) nounwind
  %call2 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([16 x i8]* @.str2, i64 0, i64 0), i64 3) nounwind
  %call3 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([16 x i8]* @.str3, i64 0, i64 0), i64 2) nounwind
  ret i32 0
}

declare i32 @printf(i8* nocapture, ...) nounwind
