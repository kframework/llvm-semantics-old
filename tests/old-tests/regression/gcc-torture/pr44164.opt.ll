; ModuleID = '/home/grosu/celliso2/c-semantics/tests/gcc-torture/pr44164.ll'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64"
target triple = "x86_64-unknown-linux-gnu"

%struct.X = type { %struct.Y }
%struct.Y = type { %struct.YY }
%struct.YY = type { %struct.Z }
%struct.Z = type { i32 }

@a = common global %struct.X zeroinitializer, align 4

define i32 @foo(%struct.Z* %p) nounwind uwtable noinline {
entry:
  %i1 = getelementptr inbounds %struct.Z* %p, i64 0, i32 0
  %tmp2 = load i32* %i1, align 4
  store i32 0, i32* getelementptr inbounds (%struct.X* @a, i64 0, i32 0, i32 0, i32 0, i32 0), align 4
  %tmp7 = load i32* %i1, align 4
  %add = add nsw i32 %tmp7, %tmp2
  ret i32 %add
}

define i32 @main() nounwind uwtable {
entry:
  store i32 1, i32* getelementptr inbounds (%struct.X* @a, i64 0, i32 0, i32 0, i32 0, i32 0), align 4
  %call = tail call i32 @foo(%struct.Z* getelementptr inbounds (%struct.X* @a, i64 0, i32 0, i32 0, i32 0))
  %cmp = icmp eq i32 %call, 1
  br i1 %cmp, label %if.end, label %if.then

if.then:                                          ; preds = %entry
  tail call void @abort() noreturn nounwind
  unreachable

if.end:                                           ; preds = %entry
  ret i32 0
}

declare void @abort() noreturn
