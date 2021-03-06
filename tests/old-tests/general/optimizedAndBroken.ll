; ModuleID = '../tests/regression/gcc-torture/20000205-1.ll'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64"
target triple = "x86_64-unknown-linux-gnu"

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

define i32 @main() noreturn nounwind uwtable {
entry:
  %call = tail call fastcc i32 @f(i32 -129)
  %tobool = icmp eq i32 %call, 0
  br i1 %tobool, label %if.end, label %if.then

if.then:                                          ; preds = %entry
  tail call void @abort() noreturn nounwind
  unreachable

if.end:                                           ; preds = %entry
  tail call void @exit(i32 0) noreturn nounwind
  unreachable
}

define internal fastcc i32 @f(i32 %a) nounwind uwtable readnone {
entry:
  %cmp = icmp eq i32 %a, 0
  br i1 %cmp, label %return, label %do.body.preheader

do.body.preheader:                                ; preds = %entry
  %and = and i32 %a, 128
  %tobool = icmp eq i32 %and, 0
  br i1 %tobool, label %do.cond, label %return

do.cond:                                          ; preds = %do.cond, %do.body.preheader
  %call = tail call fastcc i32 @f(i32 0)
  %tobool4 = icmp eq i32 %call, 0
  %tobool.not = xor i1 %tobool, true
  %brmerge = or i1 %tobool4, %tobool.not
  %0 = zext i1 %tobool4 to i32
  %.mux = xor i32 %0, 1
  br i1 %brmerge, label %return, label %do.cond

return:                                           ; preds = %do.cond, %do.body.preheader, %entry
  %retval.0 = phi i32 [ 0, %entry ], [ %.mux, %do.cond ], [ 1, %do.body.preheader ]
  ret i32 %retval.0
}

declare void @abort() noreturn nounwind

declare void @exit(i32) noreturn nounwind
