; ModuleID = '/home/grosu/celliso2/c-semantics/tests/unitTests/initStatic.c'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64"
target triple = "x86_64-unknown-linux-gnu"

%0 = type { i8, [3 x i8] }
%struct.anon = type { i32, i32 }
%union.anon = type { i32 }

@y = global i32 5, align 4
@pair = global %struct.anon { i32 2, i32 3 }, align 4
@un2 = global %0 { i8 120, [3 x i8] undef }, align 4
@x = common global i32 0, align 4
@.str = private unnamed_addr constant [8 x i8] c"x != 0\0A\00", align 1
@.str1 = private unnamed_addr constant [8 x i8] c"y != 5\0A\00", align 1
@pt = common global %struct.anon zeroinitializer, align 4
@.str2 = private unnamed_addr constant [11 x i8] c"pt.x != 0\0A\00", align 1
@.str3 = private unnamed_addr constant [11 x i8] c"pt.y != 0\0A\00", align 1
@.str4 = private unnamed_addr constant [13 x i8] c"pair.x != 2\0A\00", align 1
@.str5 = private unnamed_addr constant [13 x i8] c"pair.y != 3\0A\00", align 1
@un = common global %union.anon zeroinitializer, align 4
@.str6 = private unnamed_addr constant [11 x i8] c"un.x != 0\0A\00", align 1
@.str7 = private unnamed_addr constant [14 x i8] c"un2.x != 'x'\0A\00", align 1
@arr = common global [5 x i32] zeroinitializer, align 16
@.str8 = private unnamed_addr constant [13 x i8] c"arr[0] != 0\0A\00", align 1

define i32 @main() nounwind uwtable {
entry:
  %retval = alloca i32, align 4
  store i32 0, i32* %retval
  %tmp = load i32* @x, align 4
  %cmp = icmp ne i32 %tmp, 0
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  %call = call i32 @puts(i8* getelementptr inbounds ([8 x i8]* @.str, i32 0, i32 0))
  br label %if.end

if.end:                                           ; preds = %if.then, %entry
  %tmp1 = load i32* @y, align 4
  %cmp2 = icmp ne i32 %tmp1, 5
  br i1 %cmp2, label %if.then3, label %if.end5

if.then3:                                         ; preds = %if.end
  %call4 = call i32 @puts(i8* getelementptr inbounds ([8 x i8]* @.str1, i32 0, i32 0))
  br label %if.end5

if.end5:                                          ; preds = %if.then3, %if.end
  %tmp6 = load i32* getelementptr inbounds (%struct.anon* @pt, i32 0, i32 0), align 4
  %cmp7 = icmp ne i32 %tmp6, 0
  br i1 %cmp7, label %if.then8, label %if.end10

if.then8:                                         ; preds = %if.end5
  %call9 = call i32 @puts(i8* getelementptr inbounds ([11 x i8]* @.str2, i32 0, i32 0))
  br label %if.end10

if.end10:                                         ; preds = %if.then8, %if.end5
  %tmp11 = load i32* getelementptr inbounds (%struct.anon* @pt, i32 0, i32 1), align 4
  %cmp12 = icmp ne i32 %tmp11, 0
  br i1 %cmp12, label %if.then13, label %if.end15

if.then13:                                        ; preds = %if.end10
  %call14 = call i32 @puts(i8* getelementptr inbounds ([11 x i8]* @.str3, i32 0, i32 0))
  br label %if.end15

if.end15:                                         ; preds = %if.then13, %if.end10
  %tmp16 = load i32* getelementptr inbounds (%struct.anon* @pair, i32 0, i32 0), align 4
  %cmp17 = icmp ne i32 %tmp16, 2
  br i1 %cmp17, label %if.then18, label %if.end20

if.then18:                                        ; preds = %if.end15
  %call19 = call i32 @puts(i8* getelementptr inbounds ([13 x i8]* @.str4, i32 0, i32 0))
  br label %if.end20

if.end20:                                         ; preds = %if.then18, %if.end15
  %tmp21 = load i32* getelementptr inbounds (%struct.anon* @pair, i32 0, i32 1), align 4
  %cmp22 = icmp ne i32 %tmp21, 3
  br i1 %cmp22, label %if.then23, label %if.end25

if.then23:                                        ; preds = %if.end20
  %call24 = call i32 @puts(i8* getelementptr inbounds ([13 x i8]* @.str5, i32 0, i32 0))
  br label %if.end25

if.end25:                                         ; preds = %if.then23, %if.end20
  %tmp26 = load i8* bitcast (%union.anon* @un to i8*), align 1
  %conv = sext i8 %tmp26 to i32
  %cmp27 = icmp ne i32 %conv, 0
  br i1 %cmp27, label %if.then29, label %if.end31

if.then29:                                        ; preds = %if.end25
  %call30 = call i32 @puts(i8* getelementptr inbounds ([11 x i8]* @.str6, i32 0, i32 0))
  br label %if.end31

if.end31:                                         ; preds = %if.then29, %if.end25
  %tmp32 = load i8* getelementptr inbounds (%0* @un2, i32 0, i32 0), align 1
  %conv33 = sext i8 %tmp32 to i32
  %cmp34 = icmp ne i32 %conv33, 120
  br i1 %cmp34, label %if.then36, label %if.end38

if.then36:                                        ; preds = %if.end31
  %call37 = call i32 @puts(i8* getelementptr inbounds ([14 x i8]* @.str7, i32 0, i32 0))
  br label %if.end38

if.end38:                                         ; preds = %if.then36, %if.end31
  %tmp39 = load i32* getelementptr inbounds ([5 x i32]* @arr, i32 0, i64 0), align 4
  %cmp40 = icmp ne i32 %tmp39, 0
  br i1 %cmp40, label %if.then42, label %if.end44

if.then42:                                        ; preds = %if.end38
  %call43 = call i32 @puts(i8* getelementptr inbounds ([13 x i8]* @.str8, i32 0, i32 0))
  br label %if.end44

if.end44:                                         ; preds = %if.then42, %if.end38
  ret i32 0
}

declare i32 @puts(i8*)
