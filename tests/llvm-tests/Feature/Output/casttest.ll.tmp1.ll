; ModuleID = '<stdin>'

define i16 @FunFunc(i64 %x, i8 %z) {
bb0:
  %cast110 = sext i8 %z to i16
  %cast10 = trunc i64 %x to i16
  %reg109 = add i16 %cast110, %cast10
  ret i16 %reg109
}
