; ModuleID = '/home/grosu/celliso2/c-semantics/tests/gcc-torture/920501-1.ll'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64"
target triple = "x86_64-unknown-linux-gnu"

@s = common global [2 x i32] zeroinitializer, align 4

define i32 @x(i32 %q) nounwind uwtable {
entry:
  %tmp = load i32* getelementptr inbounds ([2 x i32]* @s, i64 0, i64 0), align 4
  %tobool = icmp eq i32 %tmp, 0
  br i1 %tobool, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  %tmp1 = load i32* getelementptr inbounds ([2 x i32]* @s, i64 0, i64 1), align 4
  %add = add nsw i32 %tmp1, 1
  %idxprom = sext i32 %add to i64
  %arrayidx = getelementptr inbounds [2 x i32]* @s, i64 0, i64 %idxprom
  store i32 %tmp1, i32* %arrayidx, align 4
  br label %if.end

if.end:                                           ; preds = %entry, %if.then
  ret i32 1
}

define i32 @main() noreturn nounwind uwtable {
if.end:
  store i32 0, i32* getelementptr inbounds ([2 x i32]* @s, i64 0, i64 0), align 4
  store i32 0, i32* getelementptr inbounds ([2 x i32]* @s, i64 0, i64 1), align 4
  tail call void @exit(i32 0) noreturn nounwind
  unreachable
}

declare void @exit(i32) noreturn
