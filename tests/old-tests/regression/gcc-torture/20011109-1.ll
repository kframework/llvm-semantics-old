; ModuleID = '/home/grosu/celliso2/c-semantics/tests/gcc-torture/20011109-1.c'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64"
target triple = "x86_64-unknown-linux-gnu"

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

define void @fail1() nounwind uwtable {
entry:
  call void @abort() noreturn nounwind
  unreachable

return:                                           ; No predecessors!
  ret void
}

declare void @abort() noreturn nounwind

define void @fail2() nounwind uwtable {
entry:
  call void @abort() noreturn nounwind
  unreachable

return:                                           ; No predecessors!
  ret void
}

define void @fail3() nounwind uwtable {
entry:
  call void @abort() noreturn nounwind
  unreachable

return:                                           ; No predecessors!
  ret void
}

define void @fail4() nounwind uwtable {
entry:
  call void @abort() noreturn nounwind
  unreachable

return:                                           ; No predecessors!
  ret void
}

define void @foo(i64 %x) nounwind uwtable {
entry:
  %x.addr = alloca i64, align 8
  store i64 %x, i64* %x.addr, align 8
  %tmp = load i64* %x.addr, align 8
  switch i64 %tmp, label %sw.default [
    i64 -6, label %sw.bb
    i64 0, label %sw.bb1
    i64 1, label %sw.bb2
    i64 2, label %sw.bb2
    i64 3, label %sw.bb3
    i64 4, label %sw.bb3
    i64 5, label %sw.bb3
  ]

sw.bb:                                            ; preds = %entry
  call void @fail1()
  br label %sw.epilog

sw.bb1:                                           ; preds = %entry
  call void @fail2()
  br label %sw.epilog

sw.bb2:                                           ; preds = %entry, %entry
  br label %sw.epilog

sw.bb3:                                           ; preds = %entry, %entry, %entry
  call void @fail3()
  br label %sw.epilog

sw.default:                                       ; preds = %entry
  call void @fail4()
  br label %sw.epilog

sw.epilog:                                        ; preds = %sw.default, %sw.bb3, %sw.bb2, %sw.bb1, %sw.bb
  %tmp4 = load i64* %x.addr, align 8
  switch i64 %tmp4, label %sw.default9 [
    i64 -3, label %sw.bb5
    i64 0, label %sw.bb6
    i64 4, label %sw.bb6
    i64 1, label %sw.bb7
    i64 3, label %sw.bb7
    i64 2, label %sw.bb8
    i64 8, label %sw.bb8
  ]

sw.bb5:                                           ; preds = %sw.epilog
  call void @fail1()
  br label %sw.epilog10

sw.bb6:                                           ; preds = %sw.epilog, %sw.epilog
  call void @fail2()
  br label %sw.epilog10

sw.bb7:                                           ; preds = %sw.epilog, %sw.epilog
  br label %sw.epilog10

sw.bb8:                                           ; preds = %sw.epilog, %sw.epilog
  call void @abort() noreturn nounwind
  unreachable

sw.default9:                                      ; preds = %sw.epilog
  call void @fail4()
  br label %sw.epilog10

sw.epilog10:                                      ; preds = %sw.default9, %sw.bb7, %sw.bb6, %sw.bb5
  ret void
}

define i32 @main() nounwind uwtable {
entry:
  %retval = alloca i32, align 4
  store i32 0, i32* %retval
  call void @foo(i64 1)
  call void @exit(i32 0) noreturn nounwind
  unreachable

return:                                           ; No predecessors!
  %0 = load i32* %retval
  ret i32 %0
}

declare void @exit(i32) noreturn nounwind
