; ModuleID = '/home/grosu/celliso2/c-semantics/tests/gcc-torture/va-arg-12.ll'
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

define void @f(double %p0, double %p1, double %p2, double %p3, double %p4, double %p5, double %p6, double %p7, double %p8, ...) nounwind uwtable {
entry:
  %select = alloca [1 x %struct.__va_list_tag], align 16
  %arraydecay1 = bitcast [1 x %struct.__va_list_tag]* %select to i8*
  call void @llvm.va_start(i8* %arraydecay1)
  %fp_offset_p = getelementptr inbounds [1 x %struct.__va_list_tag]* %select, i64 0, i64 0, i32 1
  %fp_offset = load i32* %fp_offset_p, align 4
  %fits_in_fp = icmp ult i32 %fp_offset, 161
  br i1 %fits_in_fp, label %vaarg.in_reg, label %vaarg.in_mem

vaarg.in_reg:                                     ; preds = %entry
  %0 = getelementptr inbounds [1 x %struct.__va_list_tag]* %select, i64 0, i64 0, i32 3
  %reg_save_area = load i8** %0, align 16
  %1 = sext i32 %fp_offset to i64
  %2 = getelementptr i8* %reg_save_area, i64 %1
  %3 = add i32 %fp_offset, 16
  store i32 %3, i32* %fp_offset_p, align 4
  br label %vaarg.end

vaarg.in_mem:                                     ; preds = %entry
  %overflow_arg_area_p = getelementptr inbounds [1 x %struct.__va_list_tag]* %select, i64 0, i64 0, i32 2
  %overflow_arg_area = load i8** %overflow_arg_area_p, align 8
  %overflow_arg_area.next = getelementptr i8* %overflow_arg_area, i64 8
  store i8* %overflow_arg_area.next, i8** %overflow_arg_area_p, align 8
  br label %vaarg.end

vaarg.end:                                        ; preds = %vaarg.in_mem, %vaarg.in_reg
  %fp_offset5 = phi i32 [ %3, %vaarg.in_reg ], [ %fp_offset, %vaarg.in_mem ]
  %vaarg.addr.in = phi i8* [ %2, %vaarg.in_reg ], [ %overflow_arg_area, %vaarg.in_mem ]
  %vaarg.addr = bitcast i8* %vaarg.addr.in to double*
  %4 = load double* %vaarg.addr, align 8
  %cmp = fcmp une double %4, 1.000000e+01
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %vaarg.end
  call void @abort() noreturn nounwind
  unreachable

if.end:                                           ; preds = %vaarg.end
  %fits_in_fp6 = icmp ult i32 %fp_offset5, 161
  br i1 %fits_in_fp6, label %vaarg.in_reg7, label %vaarg.in_mem9

vaarg.in_reg7:                                    ; preds = %if.end
  %5 = getelementptr inbounds [1 x %struct.__va_list_tag]* %select, i64 0, i64 0, i32 3
  %reg_save_area8 = load i8** %5, align 16
  %6 = sext i32 %fp_offset5 to i64
  %7 = getelementptr i8* %reg_save_area8, i64 %6
  %8 = add i32 %fp_offset5, 16
  store i32 %8, i32* %fp_offset_p, align 4
  br label %vaarg.end13

vaarg.in_mem9:                                    ; preds = %if.end
  %overflow_arg_area_p10 = getelementptr inbounds [1 x %struct.__va_list_tag]* %select, i64 0, i64 0, i32 2
  %overflow_arg_area11 = load i8** %overflow_arg_area_p10, align 8
  %overflow_arg_area.next12 = getelementptr i8* %overflow_arg_area11, i64 8
  store i8* %overflow_arg_area.next12, i8** %overflow_arg_area_p10, align 8
  br label %vaarg.end13

vaarg.end13:                                      ; preds = %vaarg.in_mem9, %vaarg.in_reg7
  %fp_offset20 = phi i32 [ %8, %vaarg.in_reg7 ], [ %fp_offset5, %vaarg.in_mem9 ]
  %vaarg.addr14.in = phi i8* [ %7, %vaarg.in_reg7 ], [ %overflow_arg_area11, %vaarg.in_mem9 ]
  %vaarg.addr14 = bitcast i8* %vaarg.addr14.in to double*
  %9 = load double* %vaarg.addr14, align 8
  %cmp15 = fcmp une double %9, 1.100000e+01
  br i1 %cmp15, label %if.then16, label %if.end17

if.then16:                                        ; preds = %vaarg.end13
  call void @abort() noreturn nounwind
  unreachable

if.end17:                                         ; preds = %vaarg.end13
  %fits_in_fp21 = icmp ult i32 %fp_offset20, 161
  br i1 %fits_in_fp21, label %vaarg.in_reg22, label %vaarg.in_mem24

vaarg.in_reg22:                                   ; preds = %if.end17
  %10 = getelementptr inbounds [1 x %struct.__va_list_tag]* %select, i64 0, i64 0, i32 3
  %reg_save_area23 = load i8** %10, align 16
  %11 = sext i32 %fp_offset20 to i64
  %12 = getelementptr i8* %reg_save_area23, i64 %11
  %13 = add i32 %fp_offset20, 16
  store i32 %13, i32* %fp_offset_p, align 4
  br label %vaarg.end28

vaarg.in_mem24:                                   ; preds = %if.end17
  %overflow_arg_area_p25 = getelementptr inbounds [1 x %struct.__va_list_tag]* %select, i64 0, i64 0, i32 2
  %overflow_arg_area26 = load i8** %overflow_arg_area_p25, align 8
  %overflow_arg_area.next27 = getelementptr i8* %overflow_arg_area26, i64 8
  store i8* %overflow_arg_area.next27, i8** %overflow_arg_area_p25, align 8
  br label %vaarg.end28

vaarg.end28:                                      ; preds = %vaarg.in_mem24, %vaarg.in_reg22
  %vaarg.addr29.in = phi i8* [ %12, %vaarg.in_reg22 ], [ %overflow_arg_area26, %vaarg.in_mem24 ]
  %vaarg.addr29 = bitcast i8* %vaarg.addr29.in to double*
  %14 = load double* %vaarg.addr29, align 8
  %cmp30 = fcmp une double %14, 0.000000e+00
  br i1 %cmp30, label %if.then31, label %if.end32

if.then31:                                        ; preds = %vaarg.end28
  call void @abort() noreturn nounwind
  unreachable

if.end32:                                         ; preds = %vaarg.end28
  call void @llvm.va_end(i8* %arraydecay1)
  ret void
}

declare void @llvm.va_start(i8*) nounwind

declare void @abort() noreturn nounwind

declare void @llvm.va_end(i8*) nounwind

define i32 @main() noreturn nounwind uwtable {
entry:
  tail call void (double, double, double, double, double, double, double, double, double, ...)* @f(double 1.000000e+00, double 2.000000e+00, double 3.000000e+00, double 4.000000e+00, double 5.000000e+00, double 6.000000e+00, double 7.000000e+00, double 8.000000e+00, double 9.000000e+00, double 1.000000e+01, double 1.100000e+01, double 0.000000e+00)
  tail call void @exit(i32 0) noreturn nounwind
  unreachable
}

declare void @exit(i32) noreturn nounwind
