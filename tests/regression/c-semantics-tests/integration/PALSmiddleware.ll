; ModuleID = '/home/david/src/c-semantics/tests/integration/PALSmiddleware.c'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.cbuffer_t = type { i32, i32, i32, i8* }
%struct.A = type { i8, i8 }

@mbuf = common global %struct.cbuffer_t zeroinitializer, align 8
@a1 = common global %struct.A zeroinitializer, align 1
@arr = common global [20 x i8] zeroinitializer, align 16
@a2 = common global %struct.A zeroinitializer, align 1
@.str = private unnamed_addr constant [15 x i8] c"a1.a8 == a2.a8\00", align 1
@.str1 = private unnamed_addr constant [63 x i8] c"/home/david/src/c-semantics/tests/integration/PALSmiddleware.c\00", align 1
@__PRETTY_FUNCTION__.main = private unnamed_addr constant [11 x i8] c"int main()\00", align 1

define void @cbuffer_init(%struct.cbuffer_t* %buf, i8* %arr, i32 %size) nounwind uwtable {
entry:
  %buf.addr = alloca %struct.cbuffer_t*, align 8
  %arr.addr = alloca i8*, align 8
  %size.addr = alloca i32, align 4
  store %struct.cbuffer_t* %buf, %struct.cbuffer_t** %buf.addr, align 8
  store i8* %arr, i8** %arr.addr, align 8
  store i32 %size, i32* %size.addr, align 4
  %0 = load i8** %arr.addr, align 8
  %1 = load %struct.cbuffer_t** %buf.addr, align 8
  %buf1 = getelementptr inbounds %struct.cbuffer_t* %1, i32 0, i32 3
  store i8* %0, i8** %buf1, align 8
  %2 = load i32* %size.addr, align 4
  %3 = load %struct.cbuffer_t** %buf.addr, align 8
  %maxBufSize = getelementptr inbounds %struct.cbuffer_t* %3, i32 0, i32 2
  store i32 %2, i32* %maxBufSize, align 4
  %4 = load %struct.cbuffer_t** %buf.addr, align 8
  %len = getelementptr inbounds %struct.cbuffer_t* %4, i32 0, i32 0
  store i32 0, i32* %len, align 4
  %5 = load %struct.cbuffer_t** %buf.addr, align 8
  %ptr = getelementptr inbounds %struct.cbuffer_t* %5, i32 0, i32 1
  store i32 0, i32* %ptr, align 4
  ret void
}

define i32 @cbuffer_append_int8(%struct.cbuffer_t* %buf, i8 signext %n) nounwind uwtable {
entry:
  %buf.addr = alloca %struct.cbuffer_t*, align 8
  %n.addr = alloca i8, align 1
  store %struct.cbuffer_t* %buf, %struct.cbuffer_t** %buf.addr, align 8
  store i8 %n, i8* %n.addr, align 1
  %0 = load i8* %n.addr, align 1
  %1 = load %struct.cbuffer_t** %buf.addr, align 8
  %buf1 = getelementptr inbounds %struct.cbuffer_t* %1, i32 0, i32 3
  %2 = load i8** %buf1, align 8
  %3 = load %struct.cbuffer_t** %buf.addr, align 8
  %len = getelementptr inbounds %struct.cbuffer_t* %3, i32 0, i32 0
  %4 = load i32* %len, align 4
  %idx.ext = sext i32 %4 to i64
  %add.ptr = getelementptr inbounds i8* %2, i64 %idx.ext
  store i8 %0, i8* %add.ptr, align 1
  %5 = load %struct.cbuffer_t** %buf.addr, align 8
  %len2 = getelementptr inbounds %struct.cbuffer_t* %5, i32 0, i32 0
  %6 = load i32* %len2, align 4
  %inc = add nsw i32 %6, 1
  store i32 %inc, i32* %len2, align 4
  ret i32 1
}

define i32 @cbuffer_retrieve_int8(%struct.cbuffer_t* %buf, i8* %n) nounwind uwtable {
entry:
  %buf.addr = alloca %struct.cbuffer_t*, align 8
  %n.addr = alloca i8*, align 8
  store %struct.cbuffer_t* %buf, %struct.cbuffer_t** %buf.addr, align 8
  store i8* %n, i8** %n.addr, align 8
  %0 = load %struct.cbuffer_t** %buf.addr, align 8
  %buf1 = getelementptr inbounds %struct.cbuffer_t* %0, i32 0, i32 3
  %1 = load i8** %buf1, align 8
  %2 = load %struct.cbuffer_t** %buf.addr, align 8
  %ptr = getelementptr inbounds %struct.cbuffer_t* %2, i32 0, i32 1
  %3 = load i32* %ptr, align 4
  %idx.ext = sext i32 %3 to i64
  %add.ptr = getelementptr inbounds i8* %1, i64 %idx.ext
  %4 = load i8* %add.ptr, align 1
  %5 = load i8** %n.addr, align 8
  store i8 %4, i8* %5, align 1
  %6 = load %struct.cbuffer_t** %buf.addr, align 8
  %ptr2 = getelementptr inbounds %struct.cbuffer_t* %6, i32 0, i32 1
  %7 = load i32* %ptr2, align 4
  %inc = add nsw i32 %7, 1
  store i32 %inc, i32* %ptr2, align 4
  ret i32 1
}

define i32 @main() nounwind uwtable {
entry:
  %retval = alloca i32, align 4
  %buf = alloca %struct.cbuffer_t*, align 8
  store i32 0, i32* %retval
  store %struct.cbuffer_t* @mbuf, %struct.cbuffer_t** %buf, align 8
  store i8 97, i8* getelementptr inbounds (%struct.A* @a1, i32 0, i32 0), align 1
  store i8 98, i8* getelementptr inbounds (%struct.A* @a1, i32 0, i32 1), align 1
  %0 = load %struct.cbuffer_t** %buf, align 8
  call void @cbuffer_init(%struct.cbuffer_t* %0, i8* getelementptr inbounds ([20 x i8]* @arr, i32 0, i32 0), i32 20)
  %1 = load %struct.cbuffer_t** %buf, align 8
  %2 = load i8* getelementptr inbounds (%struct.A* @a1, i32 0, i32 0), align 1
  %call = call i32 @cbuffer_append_int8(%struct.cbuffer_t* %1, i8 signext %2)
  %3 = load %struct.cbuffer_t** %buf, align 8
  %call1 = call i32 @cbuffer_retrieve_int8(%struct.cbuffer_t* %3, i8* getelementptr inbounds (%struct.A* @a2, i32 0, i32 0))
  %4 = load i8* getelementptr inbounds (%struct.A* @a1, i32 0, i32 0), align 1
  %conv = sext i8 %4 to i32
  %5 = load i8* getelementptr inbounds (%struct.A* @a2, i32 0, i32 0), align 1
  %conv2 = sext i8 %5 to i32
  %cmp = icmp eq i32 %conv, %conv2
  br i1 %cmp, label %cond.true, label %cond.false

cond.true:                                        ; preds = %entry
  br label %cond.end

cond.false:                                       ; preds = %entry
  call void @__assert_fail(i8* getelementptr inbounds ([15 x i8]* @.str, i32 0, i32 0), i8* getelementptr inbounds ([63 x i8]* @.str1, i32 0, i32 0), i32 66, i8* getelementptr inbounds ([11 x i8]* @__PRETTY_FUNCTION__.main, i32 0, i32 0)) noreturn nounwind
  unreachable
                                                  ; No predecessors!
  br label %cond.end

cond.end:                                         ; preds = %6, %cond.true
  ret i32 0
}

declare void @__assert_fail(i8*, i8*, i32, i8*) noreturn nounwind
