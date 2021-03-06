val x = (3, (4, (5, 6)))

val x1 = #2 x
(* = (4, (5, 6)) *)

val x2 = #1 x
(* = 3 *)

val x3 = #2 (#2 x)
(* = (5, 6) *)

val y = (#2 x, (#1 x, #2 (#2 x)))
(* = ((4, (5, 6)), (3, (5, 6))) *)

(* (int * (int * int)) * int *)
val ans = (#2 y, 4) (* = ((3, (5, 6), 4)) *)
