; ModuleID = '/home/david/src/c-semantics/tests/gcc-torture/20000707-1.c'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.baz = type { i32, i32, i32 }

@main.x = private unnamed_addr constant %struct.baz { i32 3, i32 4, i32 5 }, align 4

define void @foo(i32 %a, i32 %b, i32 %c) nounwind uwtable {
entry:
  %a.addr = alloca i32, align 4
  %b.addr = alloca i32, align 4
  %c.addr = alloca i32, align 4
  store i32 %a, i32* %a.addr, align 4
  store i32 %b, i32* %b.addr, align 4
  store i32 %c, i32* %c.addr, align 4
  %0 = load i32* %a.addr, align 4
  %cmp = icmp ne i32 %0, 4
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  call void @abort() noreturn
  unreachable

if.end:                                           ; preds = %entry
  ret void
}

declare void @abort() noreturn

define void @bar(i64 %x.coerce0, i32 %x.coerce1, i32 %b, i32 %c) nounwind uwtable {
entry:
  %x = alloca %struct.baz, align 8
  %coerce = alloca { i64, i32 }, align 8
  %b.addr = alloca i32, align 4
  %c.addr = alloca i32, align 4
  %0 = getelementptr { i64, i32 }* %coerce, i32 0, i32 0
  store i64 %x.coerce0, i64* %0
  %1 = getelementptr { i64, i32 }* %coerce, i32 0, i32 1
  store i32 %x.coerce1, i32* %1
  %2 = bitcast %struct.baz* %x to i8*
  %3 = bitcast { i64, i32 }* %coerce to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %2, i8* %3, i64 12, i32 8, i1 false)
  store i32 %b, i32* %b.addr, align 4
  store i32 %c, i32* %c.addr, align 4
  %b1 = getelementptr inbounds %struct.baz* %x, i32 0, i32 1
  %4 = load i32* %b1, align 4
  %5 = load i32* %b.addr, align 4
  %6 = load i32* %c.addr, align 4
  call void @foo(i32 %4, i32 %5, i32 %6)
  ret void
}

declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture, i8* nocapture, i64, i32, i1) nounwind

define i32 @main() nounwind uwtable {
entry:
  %retval = alloca i32, align 4
  %x = alloca %struct.baz, align 4
  store i32 0, i32* %retval
  %0 = bitcast %struct.baz* %x to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %0, i8* bitcast (%struct.baz* @main.x to i8*), i64 12, i32 4, i1 false)
  %1 = bitcast %struct.baz* %x to { i64, i32 }*
  %2 = getelementptr { i64, i32 }* %1, i32 0, i32 0
  %3 = load i64* %2, align 1
  %4 = getelementptr { i64, i32 }* %1, i32 0, i32 1
  %5 = load i32* %4, align 1
  call void @bar(i64 %3, i32 %5, i32 1, i32 2)
  call void @exit(i32 0) noreturn
  unreachable

return:                                           ; No predecessors!
  %6 = load i32* %retval
  ret i32 %6
}

declare void @exit(i32) noreturn
