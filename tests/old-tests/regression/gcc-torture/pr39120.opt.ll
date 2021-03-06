; ModuleID = '/home/grosu/celliso2/c-semantics/tests/gcc-torture/pr39120.ll'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64"
target triple = "x86_64-unknown-linux-gnu"

%struct.X = type { i32* }

@x = common global %struct.X zeroinitializer, align 8

define i32* @foo(i32* %p) nounwind uwtable readnone noinline {
entry:
  ret i32* %p
}

define void @bar() nounwind uwtable noinline {
entry:
  %tmp = load i32** getelementptr inbounds (%struct.X* @x, i64 0, i32 0), align 8
  store i32 1, i32* %tmp, align 4
  ret void
}

define i32 @main() nounwind uwtable {
entry:
  %i = alloca i32, align 4
  store i32 0, i32* %i, align 4
  %call = call i32* @foo(i32* %i)
  store i32* %call, i32** getelementptr inbounds (%struct.X* @x, i64 0, i32 0), align 8
  call void @bar()
  %tmp = load i32* %i, align 4
  %cmp = icmp eq i32 %tmp, 1
  br i1 %cmp, label %if.end, label %if.then

if.then:                                          ; preds = %entry
  call void @abort() noreturn nounwind
  unreachable

if.end:                                           ; preds = %entry
  ret i32 0
}

declare void @abort() noreturn
