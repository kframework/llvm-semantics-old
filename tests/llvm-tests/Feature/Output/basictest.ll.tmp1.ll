; ModuleID = '<stdin>'

define void @void(i32, i32) {
  %3 = add i32 0, 0
  %4 = sub i32 0, 4
  br label %5

; <label>:5                                       ; preds = %5, %2
  %6 = add i32 %0, %1
  %7 = sub i32 %6, %4
  %8 = icmp sle i32 %7, %3
  br i1 %8, label %9, label %5

; <label>:9                                       ; preds = %5
  %10 = add i32 %0, %1
  %11 = sub i32 %6, %4
  %12 = icmp sle i32 %11, %3
  ret void
}

define i32 @zarro() {
Startup:
  ret i32 0
}
