; ModuleID = '/home/grosu/celliso2/c-semantics/tests/gcc-torture/931004-12.ll'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64"
target triple = "x86_64-unknown-linux-gnu"

%struct.__va_list_tag = type { i32, i32, i8*, i8* }

define i32 @gnu_dev_major(i64 %__dev) nounwind uwtable readnone inlinehint {
entry:
  %shr = lshr i64 %__dev, 8
  %and = and i64 %shr, 4095
  %shr2 = lshr i64 %__dev, 32
  %and3 = and i64 %shr2, 4294963200
  %or = or i64 %and, %and3
  %conv5 = trunc i64 %or to i32
  ret i32 %conv5
}

define i32 @gnu_dev_minor(i64 %__dev) nounwind uwtable readnone inlinehint {
entry:
  %and = and i64 %__dev, 255
  %shr = lshr i64 %__dev, 12
  %and2 = and i64 %shr, 4294967040
  %or = or i64 %and2, %and
  %conv4 = trunc i64 %or to i32
  ret i32 %conv4
}

define i64 @gnu_dev_makedev(i32 %__major, i32 %__minor) nounwind uwtable readnone inlinehint {
entry:
  %and = and i32 %__minor, 255
  %and2 = shl i32 %__major, 8
  %shl = and i32 %and2, 1048320
  %or = or i32 %and, %shl
  %conv = zext i32 %or to i64
  %and4 = and i32 %__minor, -256
  %conv5 = zext i32 %and4 to i64
  %shl6 = shl nuw nsw i64 %conv5, 12
  %and9 = and i32 %__major, -4096
  %conv10 = zext i32 %and9 to i64
  %shl11 = shl nuw i64 %conv10, 32
  %or7 = or i64 %shl6, %shl11
  %or12 = or i64 %or7, %conv
  ret i64 %or12
}

define void @f(i32 %n, ...) nounwind uwtable {
entry:
  %ap = alloca [1 x %struct.__va_list_tag], align 16
  %arraydecay1 = bitcast [1 x %struct.__va_list_tag]* %ap to i8*
  call void @llvm.va_start(i8* %arraydecay1)
  %gp_offset_p = getelementptr inbounds [1 x %struct.__va_list_tag]* %ap, i64 0, i64 0, i32 0
  %0 = getelementptr inbounds [1 x %struct.__va_list_tag]* %ap, i64 0, i64 0, i32 3
  %overflow_arg_area_p = getelementptr inbounds [1 x %struct.__va_list_tag]* %ap, i64 0, i64 0, i32 2
  %gp_offset.pre = load i32* %gp_offset_p, align 16
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %gp_offset = phi i32 [ %gp_offset.pre, %entry ], [ %gp_offset22, %for.inc ]
  %1 = phi i32 [ 0, %entry ], [ %inc, %for.inc ]
  %add21 = add i32 %1, 30
  %add13 = add i32 %1, 20
  %add = add i32 %1, 10
  %cmp = icmp slt i32 %1, %n
  %fits_in_gp = icmp ult i32 %gp_offset, 41
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  br i1 %fits_in_gp, label %vaarg.in_reg, label %vaarg.in_mem

vaarg.in_reg:                                     ; preds = %for.body
  %reg_save_area = load i8** %0, align 16
  %2 = sext i32 %gp_offset to i64
  %3 = getelementptr i8* %reg_save_area, i64 %2
  %4 = add i32 %gp_offset, 8
  store i32 %4, i32* %gp_offset_p, align 16
  br label %vaarg.end

vaarg.in_mem:                                     ; preds = %for.body
  %overflow_arg_area = load i8** %overflow_arg_area_p, align 8
  %overflow_arg_area.next = getelementptr i8* %overflow_arg_area, i64 8
  store i8* %overflow_arg_area.next, i8** %overflow_arg_area_p, align 8
  br label %vaarg.end

vaarg.end:                                        ; preds = %vaarg.in_mem, %vaarg.in_reg
  %gp_offset22 = phi i32 [ %4, %vaarg.in_reg ], [ %gp_offset, %vaarg.in_mem ]
  %vaarg.addr.in = phi i8* [ %3, %vaarg.in_reg ], [ %overflow_arg_area, %vaarg.in_mem ]
  %tmp = load i8* %vaarg.addr.in, align 1
  %5 = getelementptr inbounds i8* %vaarg.addr.in, i64 2
  %tmp3 = load i8* %5, align 1
  %conv = sext i8 %tmp to i32
  %cmp8 = icmp eq i32 %conv, %add
  br i1 %cmp8, label %if.end, label %if.then

if.then:                                          ; preds = %vaarg.end
  call void @abort() noreturn nounwind
  unreachable

if.end:                                           ; preds = %vaarg.end
  %6 = getelementptr inbounds i8* %vaarg.addr.in, i64 1
  %tmp2 = load i8* %6, align 1
  %conv11 = sext i8 %tmp2 to i32
  %cmp14 = icmp eq i32 %conv11, %add13
  br i1 %cmp14, label %if.end17, label %if.then16

if.then16:                                        ; preds = %if.end
  call void @abort() noreturn nounwind
  unreachable

if.end17:                                         ; preds = %if.end
  %conv19 = sext i8 %tmp3 to i32
  %cmp22 = icmp eq i32 %conv19, %add21
  br i1 %cmp22, label %for.inc, label %if.then24

if.then24:                                        ; preds = %if.end17
  call void @abort() noreturn nounwind
  unreachable

for.inc:                                          ; preds = %if.end17
  %inc = add nsw i32 %1, 1
  br label %for.cond

for.end:                                          ; preds = %for.cond
  br i1 %fits_in_gp, label %vaarg.in_reg33, label %vaarg.in_mem35

vaarg.in_reg33:                                   ; preds = %for.end
  %reg_save_area34 = load i8** %0, align 16
  %7 = sext i32 %gp_offset to i64
  %8 = getelementptr i8* %reg_save_area34, i64 %7
  %9 = add i32 %gp_offset, 8
  store i32 %9, i32* %gp_offset_p, align 16
  br label %vaarg.end39

vaarg.in_mem35:                                   ; preds = %for.end
  %overflow_arg_area37 = load i8** %overflow_arg_area_p, align 8
  %overflow_arg_area.next38 = getelementptr i8* %overflow_arg_area37, i64 8
  store i8* %overflow_arg_area.next38, i8** %overflow_arg_area_p, align 8
  br label %vaarg.end39

vaarg.end39:                                      ; preds = %vaarg.in_mem35, %vaarg.in_reg33
  %vaarg.addr40.in = phi i8* [ %8, %vaarg.in_reg33 ], [ %overflow_arg_area37, %vaarg.in_mem35 ]
  %vaarg.addr40 = bitcast i8* %vaarg.addr40.in to i64*
  %10 = load i64* %vaarg.addr40, align 8
  %cmp42 = icmp eq i64 %10, 123
  br i1 %cmp42, label %if.end45, label %if.then44

if.then44:                                        ; preds = %vaarg.end39
  call void @abort() noreturn nounwind
  unreachable

if.end45:                                         ; preds = %vaarg.end39
  call void @llvm.va_end(i8* %arraydecay1)
  ret void
}

declare void @llvm.va_start(i8*) nounwind

declare void @abort() noreturn nounwind

declare void @llvm.va_end(i8*) nounwind

define i32 @main() noreturn nounwind uwtable {
entry:
  tail call void (i32, ...)* @f(i32 3, i24 1971210, i24 2037003, i24 2102796, i64 123)
  tail call void @exit(i32 0) noreturn nounwind
  unreachable
}

declare void @exit(i32) noreturn nounwind
