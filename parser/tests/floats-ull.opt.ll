; ModuleID = '/home/grosu/celliso2/c-semantics/tests/unitTests/floats-ull.ll'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64"
target triple = "x86_64-unknown-linux-gnu"

define i64 @f2ull(float %f) nounwind uwtable readnone {
entry:
  %conv = fptoui float %f to i64
  ret i64 %conv
}

define i64 @d2ull(double %d) nounwind uwtable readnone {
entry:
  %conv = fptoui double %d to i64
  ret i64 %conv
}

define i32 @main() nounwind uwtable {
if.end29:
  ret i32 0
}
