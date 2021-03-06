; ModuleID = '/home/grosu/celliso2/c-semantics/tests/gcc-torture/va-arg-6.c'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64"
target triple = "x86_64-unknown-linux-gnu"

%struct.__va_list_tag = type { i32, i32, i8*, i8* }

define i32 @gnu_dev_major(i64 %__dev) nounwind uwtable inlinehint {
entry:
  %__dev.addr = alloca i64, align 8
  store i64 %__dev, i64* %__dev.addr, align 8
  %tmp = load i64* %__dev.addr, align 8
  %shr = lshr i64 %tmp, 8
  %and = and i64 %shr, 4095
  %tmp1 = load i64* %__dev.addr, align 8
  %shr2 = lshr i64 %tmp1, 32
  %conv = trunc i64 %shr2 to i32
  %and3 = and i32 %conv, -4096
  %conv4 = zext i32 %and3 to i64
  %or = or i64 %and, %conv4
  %conv5 = trunc i64 %or to i32
  ret i32 %conv5
}

define i32 @gnu_dev_minor(i64 %__dev) nounwind uwtable inlinehint {
entry:
  %__dev.addr = alloca i64, align 8
  store i64 %__dev, i64* %__dev.addr, align 8
  %tmp = load i64* %__dev.addr, align 8
  %and = and i64 %tmp, 255
  %tmp1 = load i64* %__dev.addr, align 8
  %shr = lshr i64 %tmp1, 12
  %conv = trunc i64 %shr to i32
  %and2 = and i32 %conv, -256
  %conv3 = zext i32 %and2 to i64
  %or = or i64 %and, %conv3
  %conv4 = trunc i64 %or to i32
  ret i32 %conv4
}

define i64 @gnu_dev_makedev(i32 %__major, i32 %__minor) nounwind uwtable inlinehint {
entry:
  %__major.addr = alloca i32, align 4
  %__minor.addr = alloca i32, align 4
  store i32 %__major, i32* %__major.addr, align 4
  store i32 %__minor, i32* %__minor.addr, align 4
  %tmp = load i32* %__minor.addr, align 4
  %and = and i32 %tmp, 255
  %tmp1 = load i32* %__major.addr, align 4
  %and2 = and i32 %tmp1, 4095
  %shl = shl i32 %and2, 8
  %or = or i32 %and, %shl
  %conv = zext i32 %or to i64
  %tmp3 = load i32* %__minor.addr, align 4
  %and4 = and i32 %tmp3, -256
  %conv5 = zext i32 %and4 to i64
  %shl6 = shl i64 %conv5, 12
  %or7 = or i64 %conv, %shl6
  %tmp8 = load i32* %__major.addr, align 4
  %and9 = and i32 %tmp8, -4096
  %conv10 = zext i32 %and9 to i64
  %shl11 = shl i64 %conv10, 32
  %or12 = or i64 %or7, %shl11
  ret i64 %or12
}

define void @f(i32 %n, ...) nounwind uwtable {
entry:
  %n.addr = alloca i32, align 4
  %args = alloca [1 x %struct.__va_list_tag], align 16
  store i32 %n, i32* %n.addr, align 4
  %arraydecay = getelementptr inbounds [1 x %struct.__va_list_tag]* %args, i32 0, i32 0
  %arraydecay1 = bitcast %struct.__va_list_tag* %arraydecay to i8*
  call void @llvm.va_start(i8* %arraydecay1)
  %arraydecay2 = getelementptr inbounds [1 x %struct.__va_list_tag]* %args, i32 0, i32 0
  %gp_offset_p = getelementptr inbounds %struct.__va_list_tag* %arraydecay2, i32 0, i32 0
  %gp_offset = load i32* %gp_offset_p
  %fits_in_gp = icmp ule i32 %gp_offset, 40
  br i1 %fits_in_gp, label %vaarg.in_reg, label %vaarg.in_mem

vaarg.in_reg:                                     ; preds = %entry
  %0 = getelementptr inbounds %struct.__va_list_tag* %arraydecay2, i32 0, i32 3
  %reg_save_area = load i8** %0
  %1 = getelementptr i8* %reg_save_area, i32 %gp_offset
  %2 = bitcast i8* %1 to i32*
  %3 = add i32 %gp_offset, 8
  store i32 %3, i32* %gp_offset_p
  br label %vaarg.end

vaarg.in_mem:                                     ; preds = %entry
  %overflow_arg_area_p = getelementptr inbounds %struct.__va_list_tag* %arraydecay2, i32 0, i32 2
  %overflow_arg_area = load i8** %overflow_arg_area_p
  %4 = bitcast i8* %overflow_arg_area to i32*
  %overflow_arg_area.next = getelementptr i8* %overflow_arg_area, i32 8
  store i8* %overflow_arg_area.next, i8** %overflow_arg_area_p
  br label %vaarg.end

vaarg.end:                                        ; preds = %vaarg.in_mem, %vaarg.in_reg
  %vaarg.addr = phi i32* [ %2, %vaarg.in_reg ], [ %4, %vaarg.in_mem ]
  %5 = load i32* %vaarg.addr
  %cmp = icmp ne i32 %5, 10
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %vaarg.end
  call void @abort() noreturn nounwind
  unreachable

if.end:                                           ; preds = %vaarg.end
  %arraydecay3 = getelementptr inbounds [1 x %struct.__va_list_tag]* %args, i32 0, i32 0
  %gp_offset_p4 = getelementptr inbounds %struct.__va_list_tag* %arraydecay3, i32 0, i32 0
  %gp_offset5 = load i32* %gp_offset_p4
  %fits_in_gp6 = icmp ule i32 %gp_offset5, 40
  br i1 %fits_in_gp6, label %vaarg.in_reg7, label %vaarg.in_mem9

vaarg.in_reg7:                                    ; preds = %if.end
  %6 = getelementptr inbounds %struct.__va_list_tag* %arraydecay3, i32 0, i32 3
  %reg_save_area8 = load i8** %6
  %7 = getelementptr i8* %reg_save_area8, i32 %gp_offset5
  %8 = bitcast i8* %7 to i64*
  %9 = add i32 %gp_offset5, 8
  store i32 %9, i32* %gp_offset_p4
  br label %vaarg.end13

vaarg.in_mem9:                                    ; preds = %if.end
  %overflow_arg_area_p10 = getelementptr inbounds %struct.__va_list_tag* %arraydecay3, i32 0, i32 2
  %overflow_arg_area11 = load i8** %overflow_arg_area_p10
  %10 = bitcast i8* %overflow_arg_area11 to i64*
  %overflow_arg_area.next12 = getelementptr i8* %overflow_arg_area11, i32 8
  store i8* %overflow_arg_area.next12, i8** %overflow_arg_area_p10
  br label %vaarg.end13

vaarg.end13:                                      ; preds = %vaarg.in_mem9, %vaarg.in_reg7
  %vaarg.addr14 = phi i64* [ %8, %vaarg.in_reg7 ], [ %10, %vaarg.in_mem9 ]
  %11 = load i64* %vaarg.addr14
  %cmp15 = icmp ne i64 %11, 10000000000
  br i1 %cmp15, label %if.then16, label %if.end17

if.then16:                                        ; preds = %vaarg.end13
  call void @abort() noreturn nounwind
  unreachable

if.end17:                                         ; preds = %vaarg.end13
  %arraydecay18 = getelementptr inbounds [1 x %struct.__va_list_tag]* %args, i32 0, i32 0
  %gp_offset_p19 = getelementptr inbounds %struct.__va_list_tag* %arraydecay18, i32 0, i32 0
  %gp_offset20 = load i32* %gp_offset_p19
  %fits_in_gp21 = icmp ule i32 %gp_offset20, 40
  br i1 %fits_in_gp21, label %vaarg.in_reg22, label %vaarg.in_mem24

vaarg.in_reg22:                                   ; preds = %if.end17
  %12 = getelementptr inbounds %struct.__va_list_tag* %arraydecay18, i32 0, i32 3
  %reg_save_area23 = load i8** %12
  %13 = getelementptr i8* %reg_save_area23, i32 %gp_offset20
  %14 = bitcast i8* %13 to i32*
  %15 = add i32 %gp_offset20, 8
  store i32 %15, i32* %gp_offset_p19
  br label %vaarg.end28

vaarg.in_mem24:                                   ; preds = %if.end17
  %overflow_arg_area_p25 = getelementptr inbounds %struct.__va_list_tag* %arraydecay18, i32 0, i32 2
  %overflow_arg_area26 = load i8** %overflow_arg_area_p25
  %16 = bitcast i8* %overflow_arg_area26 to i32*
  %overflow_arg_area.next27 = getelementptr i8* %overflow_arg_area26, i32 8
  store i8* %overflow_arg_area.next27, i8** %overflow_arg_area_p25
  br label %vaarg.end28

vaarg.end28:                                      ; preds = %vaarg.in_mem24, %vaarg.in_reg22
  %vaarg.addr29 = phi i32* [ %14, %vaarg.in_reg22 ], [ %16, %vaarg.in_mem24 ]
  %17 = load i32* %vaarg.addr29
  %cmp30 = icmp ne i32 %17, 11
  br i1 %cmp30, label %if.then31, label %if.end32

if.then31:                                        ; preds = %vaarg.end28
  call void @abort() noreturn nounwind
  unreachable

if.end32:                                         ; preds = %vaarg.end28
  %arraydecay33 = getelementptr inbounds [1 x %struct.__va_list_tag]* %args, i32 0, i32 0
  %overflow_arg_area_p34 = getelementptr inbounds %struct.__va_list_tag* %arraydecay33, i32 0, i32 2
  %overflow_arg_area35 = load i8** %overflow_arg_area_p34
  %18 = getelementptr i8* %overflow_arg_area35, i32 15
  %19 = ptrtoint i8* %18 to i64
  %20 = and i64 %19, -16
  %overflow_arg_area.align = inttoptr i64 %20 to i8*
  %21 = bitcast i8* %overflow_arg_area.align to x86_fp80*
  %overflow_arg_area.next36 = getelementptr i8* %overflow_arg_area.align, i32 16
  store i8* %overflow_arg_area.next36, i8** %overflow_arg_area_p34
  %22 = load x86_fp80* %21
  %cmp37 = fcmp une x86_fp80 %22, 0xK4000C8F5C28F5C28F5C3
  br i1 %cmp37, label %if.then38, label %if.end39

if.then38:                                        ; preds = %if.end32
  call void @abort() noreturn nounwind
  unreachable

if.end39:                                         ; preds = %if.end32
  %arraydecay40 = getelementptr inbounds [1 x %struct.__va_list_tag]* %args, i32 0, i32 0
  %gp_offset_p41 = getelementptr inbounds %struct.__va_list_tag* %arraydecay40, i32 0, i32 0
  %gp_offset42 = load i32* %gp_offset_p41
  %fits_in_gp43 = icmp ule i32 %gp_offset42, 40
  br i1 %fits_in_gp43, label %vaarg.in_reg44, label %vaarg.in_mem46

vaarg.in_reg44:                                   ; preds = %if.end39
  %23 = getelementptr inbounds %struct.__va_list_tag* %arraydecay40, i32 0, i32 3
  %reg_save_area45 = load i8** %23
  %24 = getelementptr i8* %reg_save_area45, i32 %gp_offset42
  %25 = bitcast i8* %24 to i32*
  %26 = add i32 %gp_offset42, 8
  store i32 %26, i32* %gp_offset_p41
  br label %vaarg.end50

vaarg.in_mem46:                                   ; preds = %if.end39
  %overflow_arg_area_p47 = getelementptr inbounds %struct.__va_list_tag* %arraydecay40, i32 0, i32 2
  %overflow_arg_area48 = load i8** %overflow_arg_area_p47
  %27 = bitcast i8* %overflow_arg_area48 to i32*
  %overflow_arg_area.next49 = getelementptr i8* %overflow_arg_area48, i32 8
  store i8* %overflow_arg_area.next49, i8** %overflow_arg_area_p47
  br label %vaarg.end50

vaarg.end50:                                      ; preds = %vaarg.in_mem46, %vaarg.in_reg44
  %vaarg.addr51 = phi i32* [ %25, %vaarg.in_reg44 ], [ %27, %vaarg.in_mem46 ]
  %28 = load i32* %vaarg.addr51
  %cmp52 = icmp ne i32 %28, 12
  br i1 %cmp52, label %if.then53, label %if.end54

if.then53:                                        ; preds = %vaarg.end50
  call void @abort() noreturn nounwind
  unreachable

if.end54:                                         ; preds = %vaarg.end50
  %arraydecay55 = getelementptr inbounds [1 x %struct.__va_list_tag]* %args, i32 0, i32 0
  %gp_offset_p56 = getelementptr inbounds %struct.__va_list_tag* %arraydecay55, i32 0, i32 0
  %gp_offset57 = load i32* %gp_offset_p56
  %fits_in_gp58 = icmp ule i32 %gp_offset57, 40
  br i1 %fits_in_gp58, label %vaarg.in_reg59, label %vaarg.in_mem61

vaarg.in_reg59:                                   ; preds = %if.end54
  %29 = getelementptr inbounds %struct.__va_list_tag* %arraydecay55, i32 0, i32 3
  %reg_save_area60 = load i8** %29
  %30 = getelementptr i8* %reg_save_area60, i32 %gp_offset57
  %31 = bitcast i8* %30 to i32*
  %32 = add i32 %gp_offset57, 8
  store i32 %32, i32* %gp_offset_p56
  br label %vaarg.end65

vaarg.in_mem61:                                   ; preds = %if.end54
  %overflow_arg_area_p62 = getelementptr inbounds %struct.__va_list_tag* %arraydecay55, i32 0, i32 2
  %overflow_arg_area63 = load i8** %overflow_arg_area_p62
  %33 = bitcast i8* %overflow_arg_area63 to i32*
  %overflow_arg_area.next64 = getelementptr i8* %overflow_arg_area63, i32 8
  store i8* %overflow_arg_area.next64, i8** %overflow_arg_area_p62
  br label %vaarg.end65

vaarg.end65:                                      ; preds = %vaarg.in_mem61, %vaarg.in_reg59
  %vaarg.addr66 = phi i32* [ %31, %vaarg.in_reg59 ], [ %33, %vaarg.in_mem61 ]
  %34 = load i32* %vaarg.addr66
  %cmp67 = icmp ne i32 %34, 13
  br i1 %cmp67, label %if.then68, label %if.end69

if.then68:                                        ; preds = %vaarg.end65
  call void @abort() noreturn nounwind
  unreachable

if.end69:                                         ; preds = %vaarg.end65
  %arraydecay70 = getelementptr inbounds [1 x %struct.__va_list_tag]* %args, i32 0, i32 0
  %gp_offset_p71 = getelementptr inbounds %struct.__va_list_tag* %arraydecay70, i32 0, i32 0
  %gp_offset72 = load i32* %gp_offset_p71
  %fits_in_gp73 = icmp ule i32 %gp_offset72, 40
  br i1 %fits_in_gp73, label %vaarg.in_reg74, label %vaarg.in_mem76

vaarg.in_reg74:                                   ; preds = %if.end69
  %35 = getelementptr inbounds %struct.__va_list_tag* %arraydecay70, i32 0, i32 3
  %reg_save_area75 = load i8** %35
  %36 = getelementptr i8* %reg_save_area75, i32 %gp_offset72
  %37 = bitcast i8* %36 to i64*
  %38 = add i32 %gp_offset72, 8
  store i32 %38, i32* %gp_offset_p71
  br label %vaarg.end80

vaarg.in_mem76:                                   ; preds = %if.end69
  %overflow_arg_area_p77 = getelementptr inbounds %struct.__va_list_tag* %arraydecay70, i32 0, i32 2
  %overflow_arg_area78 = load i8** %overflow_arg_area_p77
  %39 = bitcast i8* %overflow_arg_area78 to i64*
  %overflow_arg_area.next79 = getelementptr i8* %overflow_arg_area78, i32 8
  store i8* %overflow_arg_area.next79, i8** %overflow_arg_area_p77
  br label %vaarg.end80

vaarg.end80:                                      ; preds = %vaarg.in_mem76, %vaarg.in_reg74
  %vaarg.addr81 = phi i64* [ %37, %vaarg.in_reg74 ], [ %39, %vaarg.in_mem76 ]
  %40 = load i64* %vaarg.addr81
  %cmp82 = icmp ne i64 %40, 20000000000
  br i1 %cmp82, label %if.then83, label %if.end84

if.then83:                                        ; preds = %vaarg.end80
  call void @abort() noreturn nounwind
  unreachable

if.end84:                                         ; preds = %vaarg.end80
  %arraydecay85 = getelementptr inbounds [1 x %struct.__va_list_tag]* %args, i32 0, i32 0
  %gp_offset_p86 = getelementptr inbounds %struct.__va_list_tag* %arraydecay85, i32 0, i32 0
  %gp_offset87 = load i32* %gp_offset_p86
  %fits_in_gp88 = icmp ule i32 %gp_offset87, 40
  br i1 %fits_in_gp88, label %vaarg.in_reg89, label %vaarg.in_mem91

vaarg.in_reg89:                                   ; preds = %if.end84
  %41 = getelementptr inbounds %struct.__va_list_tag* %arraydecay85, i32 0, i32 3
  %reg_save_area90 = load i8** %41
  %42 = getelementptr i8* %reg_save_area90, i32 %gp_offset87
  %43 = bitcast i8* %42 to i32*
  %44 = add i32 %gp_offset87, 8
  store i32 %44, i32* %gp_offset_p86
  br label %vaarg.end95

vaarg.in_mem91:                                   ; preds = %if.end84
  %overflow_arg_area_p92 = getelementptr inbounds %struct.__va_list_tag* %arraydecay85, i32 0, i32 2
  %overflow_arg_area93 = load i8** %overflow_arg_area_p92
  %45 = bitcast i8* %overflow_arg_area93 to i32*
  %overflow_arg_area.next94 = getelementptr i8* %overflow_arg_area93, i32 8
  store i8* %overflow_arg_area.next94, i8** %overflow_arg_area_p92
  br label %vaarg.end95

vaarg.end95:                                      ; preds = %vaarg.in_mem91, %vaarg.in_reg89
  %vaarg.addr96 = phi i32* [ %43, %vaarg.in_reg89 ], [ %45, %vaarg.in_mem91 ]
  %46 = load i32* %vaarg.addr96
  %cmp97 = icmp ne i32 %46, 14
  br i1 %cmp97, label %if.then98, label %if.end99

if.then98:                                        ; preds = %vaarg.end95
  call void @abort() noreturn nounwind
  unreachable

if.end99:                                         ; preds = %vaarg.end95
  %arraydecay100 = getelementptr inbounds [1 x %struct.__va_list_tag]* %args, i32 0, i32 0
  %fp_offset_p = getelementptr inbounds %struct.__va_list_tag* %arraydecay100, i32 0, i32 1
  %fp_offset = load i32* %fp_offset_p
  %fits_in_fp = icmp ule i32 %fp_offset, 160
  br i1 %fits_in_fp, label %vaarg.in_reg101, label %vaarg.in_mem103

vaarg.in_reg101:                                  ; preds = %if.end99
  %47 = getelementptr inbounds %struct.__va_list_tag* %arraydecay100, i32 0, i32 3
  %reg_save_area102 = load i8** %47
  %48 = getelementptr i8* %reg_save_area102, i32 %fp_offset
  %49 = bitcast i8* %48 to double*
  %50 = add i32 %fp_offset, 16
  store i32 %50, i32* %fp_offset_p
  br label %vaarg.end107

vaarg.in_mem103:                                  ; preds = %if.end99
  %overflow_arg_area_p104 = getelementptr inbounds %struct.__va_list_tag* %arraydecay100, i32 0, i32 2
  %overflow_arg_area105 = load i8** %overflow_arg_area_p104
  %51 = bitcast i8* %overflow_arg_area105 to double*
  %overflow_arg_area.next106 = getelementptr i8* %overflow_arg_area105, i32 8
  store i8* %overflow_arg_area.next106, i8** %overflow_arg_area_p104
  br label %vaarg.end107

vaarg.end107:                                     ; preds = %vaarg.in_mem103, %vaarg.in_reg101
  %vaarg.addr108 = phi double* [ %49, %vaarg.in_reg101 ], [ %51, %vaarg.in_mem103 ]
  %52 = load double* %vaarg.addr108
  %cmp109 = fcmp une double %52, 2.720000e+00
  br i1 %cmp109, label %if.then110, label %if.end111

if.then110:                                       ; preds = %vaarg.end107
  call void @abort() noreturn nounwind
  unreachable

if.end111:                                        ; preds = %vaarg.end107
  %arraydecay112 = getelementptr inbounds [1 x %struct.__va_list_tag]* %args, i32 0, i32 0
  %arraydecay112113 = bitcast %struct.__va_list_tag* %arraydecay112 to i8*
  call void @llvm.va_end(i8* %arraydecay112113)
  ret void
}

declare void @llvm.va_start(i8*) nounwind

declare void @abort() noreturn nounwind

declare void @llvm.va_end(i8*) nounwind

define i32 @main() nounwind uwtable {
entry:
  %retval = alloca i32, align 4
  store i32 0, i32* %retval
  call void (i32, ...)* @f(i32 4, i32 10, i64 10000000000, i32 11, x86_fp80 0xK4000C8F5C28F5C28F5C3, i32 12, i32 13, i64 20000000000, i32 14, double 2.720000e+00)
  call void @exit(i32 0) noreturn nounwind
  unreachable

return:                                           ; No predecessors!
  %0 = load i32* %retval
  ret i32 %0
}

declare void @exit(i32) noreturn nounwind
