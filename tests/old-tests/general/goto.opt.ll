; ModuleID = '/home/grosu/celliso2/c-semantics/tests/unitTests/goto.ll'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64"
target triple = "x86_64-unknown-linux-gnu"

@.str = private unnamed_addr constant [10 x i8] c"local=%d\0A\00", align 1
@.str1 = private unnamed_addr constant [5 x i8] c"%d, \00", align 1
@.str5 = private unnamed_addr constant [28 x i8] c"The count is %d.  \0AThis is \00", align 1
@.str17 = private unnamed_addr constant [24 x i8] c"The test number is %d.\0A\00", align 1
@.str18 = private unnamed_addr constant [22 x i8] c"%d is an odd number.\0A\00", align 1
@.str19 = private unnamed_addr constant [15 x i8] c"gotowhile: %d\0A\00", align 1
@.str20 = private unnamed_addr constant [14 x i8] c"gotoloop: %d\0A\00", align 1
@.str21 = private unnamed_addr constant [12 x i8] c"sneaky: %d\0A\00", align 1
@.str22 = private unnamed_addr constant [14 x i8] c"myswitch: %d\0A\00", align 1
@.str23 = private unnamed_addr constant [13 x i8] c"another: %d\0A\00", align 1
@.str24 = private unnamed_addr constant [10 x i8] c"last: %d\0A\00", align 1
@str = internal constant [6 x i8] c"Done!\00"
@str1 = internal constant [7 x i8] c"sneaky\00"
@str4 = internal constant [8 x i8] c"a pair.\00"
@str6 = internal constant [30 x i8] c"inside switch, going to break\00"
@str7 = internal constant [6 x i8] c"Broke\00"
@str8 = internal constant [42 x i8] c"inside switch, going to goto another case\00"
@str10 = internal constant [18 x i8] c"jumping into case\00"
@str11 = internal constant [26 x i8] c"jumping into weird case 1\00"
@str12 = internal constant [26 x i8] c"jumping into weird case 2\00"

define i32 @gotowhile() nounwind uwtable {
entry:
  %call4 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([10 x i8]* @.str, i64 0, i64 0), i32 0) nounwind
  ret i32 0
}

declare i32 @printf(i8* nocapture, ...) nounwind

define i32 @gotoloop() nounwind uwtable {
entry:
  %call = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.str1, i64 0, i64 0), i32 10) nounwind
  %call.1 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.str1, i64 0, i64 0), i32 9) nounwind
  %call.2 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.str1, i64 0, i64 0), i32 8) nounwind
  %call.3 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.str1, i64 0, i64 0), i32 7) nounwind
  %call.4 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.str1, i64 0, i64 0), i32 6) nounwind
  %call.5 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.str1, i64 0, i64 0), i32 5) nounwind
  %call.6 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.str1, i64 0, i64 0), i32 4) nounwind
  %call.7 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.str1, i64 0, i64 0), i32 3) nounwind
  %call.8 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.str1, i64 0, i64 0), i32 2) nounwind
  %call.9 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.str1, i64 0, i64 0), i32 1) nounwind
  %puts = tail call i32 @puts(i8* getelementptr inbounds ([6 x i8]* @str, i64 0, i64 0))
  ret i32 0
}

define i32 @sneaky() nounwind uwtable {
entry:
  %puts = tail call i32 @puts(i8* getelementptr inbounds ([7 x i8]* @str1, i64 0, i64 0))
  ret i32 0
}

define i32 @last() nounwind uwtable {
entry:
  %call = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.str1, i64 0, i64 0), i32 1) nounwind
  %call.1 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.str1, i64 0, i64 0), i32 2) nounwind
  %call.2 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.str1, i64 0, i64 0), i32 3) nounwind
  %call.3 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.str1, i64 0, i64 0), i32 4) nounwind
  %call.4 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.str1, i64 0, i64 0), i32 5) nounwind
  ret i32 0
}

define i32 @another() nounwind uwtable {
entry:
  %call = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.str1, i64 0, i64 0), i32 5) nounwind
  %call.1 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.str1, i64 0, i64 0), i32 4) nounwind
  %call.2 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.str1, i64 0, i64 0), i32 3) nounwind
  %call.3 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.str1, i64 0, i64 0), i32 2) nounwind
  %call.4 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.str1, i64 0, i64 0), i32 1) nounwind
  %putchar = tail call i32 @putchar(i32 10) nounwind
  ret i32 0
}

define i32 @myswitch() nounwind uwtable {
entry:
  %call = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([28 x i8]* @.str5, i64 0, i64 0), i32 2) nounwind
  br label %insideTwo

insideTwo:                                        ; preds = %if.then, %insideFive, %entry
  %0 = phi i32 [ 0, %entry ], [ 1, %if.then ], [ 3, %insideFive ]
  %puts3 = tail call i32 @puts(i8* getelementptr inbounds ([8 x i8]* @str4, i64 0, i64 0))
  br label %next

insideFour:                                       ; preds = %next
  %puts10 = tail call i32 @puts(i8* getelementptr inbounds ([26 x i8]* @str11, i64 0, i64 0))
  %puts5 = tail call i32 @puts(i8* getelementptr inbounds ([30 x i8]* @str6, i64 0, i64 0))
  %puts6 = tail call i32 @puts(i8* getelementptr inbounds ([6 x i8]* @str7, i64 0, i64 0))
  br label %next

insideFive:                                       ; preds = %next
  %puts11 = tail call i32 @puts(i8* getelementptr inbounds ([26 x i8]* @str12, i64 0, i64 0))
  %puts7 = tail call i32 @puts(i8* getelementptr inbounds ([42 x i8]* @str8, i64 0, i64 0))
  br label %insideTwo

next:                                             ; preds = %insideFour, %insideTwo
  %1 = phi i32 [ 2, %insideFour ], [ %0, %insideTwo ]
  switch i32 %1, label %if.end27 [
    i32 0, label %if.then
    i32 1, label %insideFour
    i32 2, label %insideFive
  ]

if.then:                                          ; preds = %next
  %puts9 = tail call i32 @puts(i8* getelementptr inbounds ([18 x i8]* @str10, i64 0, i64 0))
  br label %insideTwo

if.end27:                                         ; preds = %next
  %call30 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([24 x i8]* @.str17, i64 0, i64 0), i32 4) nounwind
  br label %while.body

while.body:                                       ; preds = %if.end27, %if.end37
  %indvar = phi i32 [ %indvar.next, %if.end37 ], [ 0, %if.end27 ]
  %cmp35 = icmp eq i32 %indvar, 1
  br i1 %cmp35, label %repeatedLabel, label %if.end37

if.end37:                                         ; preds = %while.body
  %inc = add i32 %indvar, 5
  %call39 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([22 x i8]* @.str18, i64 0, i64 0), i32 %inc) nounwind
  %indvar.next = add i32 %indvar, 1
  br label %while.body

repeatedLabel:                                    ; preds = %while.body
  ret i32 1
}

define i32 @main() nounwind uwtable {
entry:
  %call4.i = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([10 x i8]* @.str, i64 0, i64 0), i32 0) nounwind
  %call1 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([15 x i8]* @.str19, i64 0, i64 0), i32 0) nounwind
  %call2 = tail call i32 @gotoloop()
  %call3 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([14 x i8]* @.str20, i64 0, i64 0), i32 0) nounwind
  %puts.i = tail call i32 @puts(i8* getelementptr inbounds ([7 x i8]* @str1, i64 0, i64 0)) nounwind
  %call5 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([12 x i8]* @.str21, i64 0, i64 0), i32 0) nounwind
  %call6 = tail call i32 @myswitch()
  %call7 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([14 x i8]* @.str22, i64 0, i64 0), i32 1) nounwind
  %call.i = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.str1, i64 0, i64 0), i32 5) nounwind
  %call.1.i = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.str1, i64 0, i64 0), i32 4) nounwind
  %call.2.i = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.str1, i64 0, i64 0), i32 3) nounwind
  %call.3.i = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.str1, i64 0, i64 0), i32 2) nounwind
  %call.4.i = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.str1, i64 0, i64 0), i32 1) nounwind
  %putchar.i = tail call i32 @putchar(i32 10) nounwind
  %call9 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str23, i64 0, i64 0), i32 0) nounwind
  %call.i1 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.str1, i64 0, i64 0), i32 1) nounwind
  %call.1.i2 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.str1, i64 0, i64 0), i32 2) nounwind
  %call.2.i3 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.str1, i64 0, i64 0), i32 3) nounwind
  %call.3.i4 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.str1, i64 0, i64 0), i32 4) nounwind
  %call.4.i5 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.str1, i64 0, i64 0), i32 5) nounwind
  %call11 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([10 x i8]* @.str24, i64 0, i64 0), i32 0) nounwind
  ret i32 0
}

declare i32 @puts(i8* nocapture) nounwind

declare i32 @putchar(i32)
