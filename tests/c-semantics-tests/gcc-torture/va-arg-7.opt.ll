; ModuleID = '/home/david/src/c-semantics/tests/gcc-torture/va-arg-7.c'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.__va_list_tag = type { i32, i32, i8*, i8* }

define i32 @main() noreturn nounwind uwtable {
entry:
  tail call void (i32, i32, i32, i32, i32, i32, i32, double, double, double, double, double, double, double, double, double, ...)* @debug(i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, double undef, double undef, double undef, double undef, double undef, double undef, double undef, double undef, double undef, i32 8, i32 9, i32 10)
  tail call void @exit(i32 0) noreturn nounwind
  unreachable
}

define available_externally void @debug(i32 %i1, i32 %i2, i32 %i3, i32 %i4, i32 %i5, i32 %i6, i32 %i7, double %f1, double %f2, double %f3, double %f4, double %f5, double %f6, double %f7, double %f8, double %f9, ...) nounwind uwtable inlinehint {
entry:
  %ap = alloca [1 x %struct.__va_list_tag], align 16
  %arraydecay = getelementptr inbounds [1 x %struct.__va_list_tag]* %ap, i64 0, i64 0
  %arraydecay1 = bitcast [1 x %struct.__va_list_tag]* %ap to i8*
  call void @llvm.va_start(i8* %arraydecay1)
  %0 = va_arg %struct.__va_list_tag* %arraydecay, i32
  %cmp = icmp eq i32 %0, 8
  br i1 %cmp, label %if.end, label %if.then

if.then:                                          ; preds = %entry
  call void @abort() noreturn nounwind
  unreachable

if.end:                                           ; preds = %entry
  %1 = va_arg %struct.__va_list_tag* %arraydecay, i32
  %cmp4 = icmp eq i32 %1, 9
  br i1 %cmp4, label %if.end6, label %if.then5

if.then5:                                         ; preds = %if.end
  call void @abort() noreturn nounwind
  unreachable

if.end6:                                          ; preds = %if.end
  %2 = va_arg %struct.__va_list_tag* %arraydecay, i32
  %cmp8 = icmp eq i32 %2, 10
  br i1 %cmp8, label %if.end10, label %if.then9

if.then9:                                         ; preds = %if.end6
  call void @abort() noreturn nounwind
  unreachable

if.end10:                                         ; preds = %if.end6
  call void @llvm.va_end(i8* %arraydecay1)
  ret void
}

declare void @exit(i32) noreturn nounwind

declare void @llvm.va_start(i8*) nounwind

declare void @abort() noreturn nounwind

declare void @llvm.va_end(i8*) nounwind
