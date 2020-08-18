(* Expressions *)
val x = 10;
val y = 50;

val z1 = (x + y) + (y + 2); (* 60 + 52 = 112 *)
val z2 = ~112;

val funky_z1 = if z1 > 0 then z1 + 1000 else 0 - z1; (* 1112 *)
val funky_z2 = if z2 > 0 then z2 + 1000 else 0 - z2; (* 112 *)

val fake_abs_z = abs(z1);
val fake_abs_z_p = abs z2; (* abs(z) is the same, but parens can be left out *)

(* addition inside conditional *)
if 4 + 1 > 0 then 5 else 0;

(* conditional inside addition *)
4 + (if x > 20 then 10 else 20);
