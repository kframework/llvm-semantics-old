; ModuleID = '/home/grosu/celliso2/c-semantics/tests/gcc-torture/951003-1.c'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64"
target triple = "x86_64-unknown-linux-gnu"

define i32 @f(i32 %i) nounwind uwtable {
entry:
  %i.addr = alloca i32, align 4
  store i32 %i, i32* %i.addr, align 4
  ret i32 12
}

define i32 @g() nounwind uwtable {
entry:
  ret i32 0
}

define i32 @main() nounwind uwtable {
entry:
  %retval = alloca i32, align 4
  %i = alloca i32, align 4
  %s = alloca i32, align 4
  store i32 0, i32* %retval
  store i32 0, i32* %i, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %tmp = load i32* %i, align 4
  %cmp = icmp slt i32 %tmp, 32
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %tmp1 = load i32* %i, align 4
  %call = call i32 (...)* bitcast (i32 (i32)* @f to i32 (...)*)(i32 %tmp1)
  store i32 %call, i32* %s, align 4
  %tmp2 = load i32* %i, align 4
  %call3 = call i32 @g()
  %cmp4 = icmp eq i32 %tmp2, %call3
  br i1 %cmp4, label %if.then, label %if.end

if.then:                                          ; preds = %for.body
  store i32 42, i32* %s, align 4
  br label %if.end

if.end:                                           ; preds = %if.then, %for.body
  %tmp5 = load i32* %i, align 4
  %cmp6 = icmp eq i32 %tmp5, 0
  br i1 %cmp6, label %if.then9, label %lor.lhs.false

lor.lhs.false:                                    ; preds = %if.end
  %tmp7 = load i32* %s, align 4
  %cmp8 = icmp eq i32 %tmp7, 12
  br i1 %cmp8, label %if.then9, label %if.else

if.then9:                                         ; preds = %lor.lhs.false, %if.end
  br label %if.end10

if.else:                                          ; preds = %lor.lhs.false
  call void @abort() noreturn
  unreachable

if.end10:                                         ; preds = %if.then9
  br label %for.inc

for.inc:                                          ; preds = %if.end10
  %tmp11 = load i32* %i, align 4
  %inc = add nsw i32 %tmp11, 1
  store i32 %inc, i32* %i, align 4
  br label %for.cond

for.end:                                          ; preds = %for.cond
  call void @exit(i32 0) noreturn
  unreachable

return:                                           ; No predecessors!
  %0 = load i32* %retval
  ret i32 %0
}

declare void @abort() noreturn

declare void @exit(i32) noreturn
