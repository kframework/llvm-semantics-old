; ModuleID = '/home/grosu/celliso2/c-semantics/tests/gcc-torture/20041113-1.ll'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64"
target triple = "x86_64-unknown-linux-gnu"

%struct.__va_list_tag = type { i32, i32, i8*, i8* }

@a = global double 4.000000e+01, align 8

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

define void @test(i32 %x, ...) nounwind uwtable {
entry:
  %ap = alloca [1 x %struct.__va_list_tag], align 16
  %arraydecay1 = bitcast [1 x %struct.__va_list_tag]* %ap to i8*
  call void @llvm.va_start(i8* %arraydecay1)
  %gp_offset_p = getelementptr inbounds [1 x %struct.__va_list_tag]* %ap, i64 0, i64 0, i32 0
  %gp_offset = load i32* %gp_offset_p, align 16
  %fits_in_gp = icmp ult i32 %gp_offset, 41
  br i1 %fits_in_gp, label %vaarg.in_reg, label %vaarg.in_mem

vaarg.in_reg:                                     ; preds = %entry
  %0 = getelementptr inbounds [1 x %struct.__va_list_tag]* %ap, i64 0, i64 0, i32 3
  %reg_save_area = load i8** %0, align 16
  %1 = sext i32 %gp_offset to i64
  %2 = getelementptr i8* %reg_save_area, i64 %1
  %3 = add i32 %gp_offset, 8
  store i32 %3, i32* %gp_offset_p, align 16
  br label %vaarg.end

vaarg.in_mem:                                     ; preds = %entry
  %overflow_arg_area_p = getelementptr inbounds [1 x %struct.__va_list_tag]* %ap, i64 0, i64 0, i32 2
  %overflow_arg_area = load i8** %overflow_arg_area_p, align 8
  %overflow_arg_area.next = getelementptr i8* %overflow_arg_area, i64 8
  store i8* %overflow_arg_area.next, i8** %overflow_arg_area_p, align 8
  br label %vaarg.end

vaarg.end:                                        ; preds = %vaarg.in_mem, %vaarg.in_reg
  %gp_offset5 = phi i32 [ %3, %vaarg.in_reg ], [ %gp_offset, %vaarg.in_mem ]
  %vaarg.addr.in = phi i8* [ %2, %vaarg.in_reg ], [ %overflow_arg_area, %vaarg.in_mem ]
  %vaarg.addr = bitcast i8* %vaarg.addr.in to i32*
  %4 = load i32* %vaarg.addr, align 4
  %cmp = icmp eq i32 %4, 1
  br i1 %cmp, label %if.end, label %if.then

if.then:                                          ; preds = %vaarg.end
  call void @abort() noreturn nounwind
  unreachable

if.end:                                           ; preds = %vaarg.end
  %fits_in_gp6 = icmp ult i32 %gp_offset5, 41
  br i1 %fits_in_gp6, label %vaarg.in_reg7, label %vaarg.in_mem9

vaarg.in_reg7:                                    ; preds = %if.end
  %5 = getelementptr inbounds [1 x %struct.__va_list_tag]* %ap, i64 0, i64 0, i32 3
  %reg_save_area8 = load i8** %5, align 16
  %6 = sext i32 %gp_offset5 to i64
  %7 = getelementptr i8* %reg_save_area8, i64 %6
  %8 = add i32 %gp_offset5, 8
  store i32 %8, i32* %gp_offset_p, align 16
  br label %vaarg.end13

vaarg.in_mem9:                                    ; preds = %if.end
  %overflow_arg_area_p10 = getelementptr inbounds [1 x %struct.__va_list_tag]* %ap, i64 0, i64 0, i32 2
  %overflow_arg_area11 = load i8** %overflow_arg_area_p10, align 8
  %overflow_arg_area.next12 = getelementptr i8* %overflow_arg_area11, i64 8
  store i8* %overflow_arg_area.next12, i8** %overflow_arg_area_p10, align 8
  br label %vaarg.end13

vaarg.end13:                                      ; preds = %vaarg.in_mem9, %vaarg.in_reg7
  %gp_offset20 = phi i32 [ %8, %vaarg.in_reg7 ], [ %gp_offset5, %vaarg.in_mem9 ]
  %vaarg.addr14.in = phi i8* [ %7, %vaarg.in_reg7 ], [ %overflow_arg_area11, %vaarg.in_mem9 ]
  %vaarg.addr14 = bitcast i8* %vaarg.addr14.in to i32*
  %9 = load i32* %vaarg.addr14, align 4
  %cmp15 = icmp eq i32 %9, 2
  br i1 %cmp15, label %if.end17, label %if.then16

if.then16:                                        ; preds = %vaarg.end13
  call void @abort() noreturn nounwind
  unreachable

if.end17:                                         ; preds = %vaarg.end13
  %fits_in_gp21 = icmp ult i32 %gp_offset20, 41
  br i1 %fits_in_gp21, label %vaarg.in_reg22, label %vaarg.in_mem24

vaarg.in_reg22:                                   ; preds = %if.end17
  %10 = getelementptr inbounds [1 x %struct.__va_list_tag]* %ap, i64 0, i64 0, i32 3
  %reg_save_area23 = load i8** %10, align 16
  %11 = sext i32 %gp_offset20 to i64
  %12 = getelementptr i8* %reg_save_area23, i64 %11
  %13 = add i32 %gp_offset20, 8
  store i32 %13, i32* %gp_offset_p, align 16
  br label %vaarg.end28

vaarg.in_mem24:                                   ; preds = %if.end17
  %overflow_arg_area_p25 = getelementptr inbounds [1 x %struct.__va_list_tag]* %ap, i64 0, i64 0, i32 2
  %overflow_arg_area26 = load i8** %overflow_arg_area_p25, align 8
  %overflow_arg_area.next27 = getelementptr i8* %overflow_arg_area26, i64 8
  store i8* %overflow_arg_area.next27, i8** %overflow_arg_area_p25, align 8
  br label %vaarg.end28

vaarg.end28:                                      ; preds = %vaarg.in_mem24, %vaarg.in_reg22
  %gp_offset35 = phi i32 [ %13, %vaarg.in_reg22 ], [ %gp_offset20, %vaarg.in_mem24 ]
  %vaarg.addr29.in = phi i8* [ %12, %vaarg.in_reg22 ], [ %overflow_arg_area26, %vaarg.in_mem24 ]
  %vaarg.addr29 = bitcast i8* %vaarg.addr29.in to i32*
  %14 = load i32* %vaarg.addr29, align 4
  %cmp30 = icmp eq i32 %14, 3
  br i1 %cmp30, label %if.end32, label %if.then31

if.then31:                                        ; preds = %vaarg.end28
  call void @abort() noreturn nounwind
  unreachable

if.end32:                                         ; preds = %vaarg.end28
  %fits_in_gp36 = icmp ult i32 %gp_offset35, 41
  br i1 %fits_in_gp36, label %vaarg.in_reg37, label %vaarg.in_mem39

vaarg.in_reg37:                                   ; preds = %if.end32
  %15 = getelementptr inbounds [1 x %struct.__va_list_tag]* %ap, i64 0, i64 0, i32 3
  %reg_save_area38 = load i8** %15, align 16
  %16 = sext i32 %gp_offset35 to i64
  %17 = getelementptr i8* %reg_save_area38, i64 %16
  %18 = add i32 %gp_offset35, 8
  store i32 %18, i32* %gp_offset_p, align 16
  br label %vaarg.end43

vaarg.in_mem39:                                   ; preds = %if.end32
  %overflow_arg_area_p40 = getelementptr inbounds [1 x %struct.__va_list_tag]* %ap, i64 0, i64 0, i32 2
  %overflow_arg_area41 = load i8** %overflow_arg_area_p40, align 8
  %overflow_arg_area.next42 = getelementptr i8* %overflow_arg_area41, i64 8
  store i8* %overflow_arg_area.next42, i8** %overflow_arg_area_p40, align 8
  br label %vaarg.end43

vaarg.end43:                                      ; preds = %vaarg.in_mem39, %vaarg.in_reg37
  %vaarg.addr44.in = phi i8* [ %17, %vaarg.in_reg37 ], [ %overflow_arg_area41, %vaarg.in_mem39 ]
  %vaarg.addr44 = bitcast i8* %vaarg.addr44.in to i32*
  %19 = load i32* %vaarg.addr44, align 4
  %cmp45 = icmp eq i32 %19, 4
  br i1 %cmp45, label %if.end47, label %if.then46

if.then46:                                        ; preds = %vaarg.end43
  call void @abort() noreturn nounwind
  unreachable

if.end47:                                         ; preds = %vaarg.end43
  ret void
}

declare void @llvm.va_start(i8*) nounwind

declare void @abort() noreturn nounwind

define i32 @main(i32 %argc, i8** nocapture %argv) noreturn nounwind uwtable {
entry:
  %tmp = load double* @a, align 8
  %div = fdiv double %tmp, 1.000000e+01
  %conv = fptosi double %div to i32
  tail call void (i32, ...)* @test(i32 0, i32 1, i32 2, i32 3, i32 %conv)
  tail call void @exit(i32 0) noreturn nounwind
  unreachable
}

declare void @exit(i32) noreturn nounwind
