; ModuleID = '/home/grosu/celliso2/c-semantics/tests/gcc-torture/20000605-3.c'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64"
target triple = "x86_64-unknown-linux-gnu"

%struct.F = type { i32, i32 }

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

define i32 @main() nounwind uwtable {
entry:
  %retval = alloca i32, align 4
  %timeout = alloca i32, align 4
  %x = alloca i32, align 4
  %i = alloca %struct.F, align 4
  store i32 0, i32* %retval
  store i32 0, i32* %timeout, align 4
  store i32 0, i32* %x, align 4
  br label %while.body

while.body:                                       ; preds = %entry, %if.end8
  %x1 = getelementptr inbounds %struct.F* %i, i32 0, i32 0
  %tmp = load i32* %x, align 4
  %inc = add nsw i32 %tmp, 1
  store i32 %inc, i32* %x, align 4
  store i32 %tmp, i32* %x1, align 4
  %y = getelementptr inbounds %struct.F* %i, i32 0, i32 1
  store i32 0, i32* %y, align 4
  %x2 = getelementptr inbounds %struct.F* %i, i32 0, i32 0
  %tmp3 = load i32* %x2, align 4
  %cmp = icmp sgt i32 %tmp3, 0
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %while.body
  br label %while.end

if.end:                                           ; preds = %while.body
  %tmp4 = load i32* %timeout, align 4
  %inc5 = add nsw i32 %tmp4, 1
  store i32 %inc5, i32* %timeout, align 4
  %cmp6 = icmp sgt i32 %inc5, 5
  br i1 %cmp6, label %if.then7, label %if.end8

if.then7:                                         ; preds = %if.end
  br label %die

if.end8:                                          ; preds = %if.end
  br label %while.body

while.end:                                        ; preds = %if.then
  ret i32 0

die:                                              ; preds = %if.then7
  call void @abort() noreturn nounwind
  unreachable
}

declare void @abort() noreturn nounwind
