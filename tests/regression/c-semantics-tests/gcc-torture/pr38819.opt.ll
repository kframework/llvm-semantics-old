; ModuleID = '/home/david/src/c-semantics/tests/gcc-torture/pr38819.c'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@a = global i32 1, align 4
@b = global i32 0, align 4
@x = global i32 2, align 4
@r = global i32 8, align 4

define void @foo() noreturn nounwind uwtable noinline {
entry:
  tail call void @exit(i32 0) noreturn nounwind
  unreachable
}

declare void @exit(i32) noreturn

define i32 @main() noreturn nounwind uwtable {
for.body:
  %0 = load volatile i32* @a, align 4, !tbaa !0
  %1 = load volatile i32* @b, align 4, !tbaa !0
  tail call void @foo()
  unreachable
}

!0 = metadata !{metadata !"int", metadata !1}
!1 = metadata !{metadata !"omnipotent char", metadata !2}
!2 = metadata !{metadata !"Simple C/C++ TBAA", null}
