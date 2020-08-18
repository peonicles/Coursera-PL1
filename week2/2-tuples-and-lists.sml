(* Tuples *)

(* Tuples contain N elements. And are fixed length.
   Pairs are a specialization of tuples, its a 2-tuple
   The type of the tuple depends on the number of elements. i.e.
   - (1,2) has type int * int,
   - (1, true, 50) has type int * bool * int
   We can't use tuples if the number of elements are dynamic
*)

(* Tuples contain N elements of any type *)
val t1 = (1, 2, true, 4) (* int * int * bool * int *)
val t2 = (true, 1, false) (* bool * int * bool *)

(* Pairs contain only 2 elements *)
val p1 = (1, false) (* int * bool *)
val p2 = (true, 2) (* bool * int *)

(* Use #N to retrive Nth element of a tuple *)
val v1 = #3 t1 (* = 3 *)
val v2 = #1 t2 (* = true *)



(* Lists *)

(* List can have any number of elements, but all elements must have the same type *)
val l1 = [] (* 'a list , empty list of type `Any` *)
val l2 = [1, 2, 3 + 4] (* int list *)
val l3 = [true, false] (* bool list *)
val l4 = [(1, 2), (3, 4)] (* (int*int) list *)

(* Operations *)
(* cons - :: , concats a value and a list *)
(* 'a, 'a list -> 'a list *)
val l11 = 500 :: l2
val l12 = true :: l3
val l13 = [~1, 0] :: [[1, 2], [3, 4]] (* int list list , list of int list *)

(* null , function that takes a list and returns true if list is empty *)
(* 'a list -> bool *)
val n1 = null []; (* true *)
val n2 = null [1, 2, 3] (* false *)

(* hd , takes a list and returns the first element *)
(* calling hd with an empty list is an exception *)
(* 'a list -> 'a *)
val hd1 = hd [1, 2, 3] (* 1 *)
val hd2 = hd [1] (* 1 *)

(* tl , takes a list and returns the list of elements without the head *)
(* calling tl with an empty list is an exception *)
(* 'a list -> 'a list *)
val tl1 = tl [1, 2, 3] (* [2, 3] *)
val tl2 = tl [1] (* [] *)

(* we can combine hd and tl to access Nth elements of a list *)
val third =  hd (tl (tl [1, 20, 50, 100])) (* 50 *)
val last =  hd (tl (tl (tl [1, 20, 50, 100]))) (* 100 *)



(* Iterating over lists with recursion *)
(* sum all items in a list *)
(* [2,3,4] --> 9 *)
fun sum_list (xs: int list) = 
    if null xs
    then 0
    else hd xs + sum_list(tl xs)

(* multiply all items in a list *)
(* [2,3,4] --> 24 *)
fun product_list (xs: int list) =
    if null xs
    then 1
    else hd xs * product_list(tl xs)

(* give a number, get a list with that number counting down to 1 *)
(* 3 -> [3,2,1] *)
fun countdown_list (n: int) =
    if n = 0
    then []
    else n :: countdown_list(n - 1)

(*
countdown_list(3)
    --> 3 :: countdown_list(2)
    --> 3 :: 2 :: countdown_list(1)
    --> 3 :: 2 :: 1 :: countdown_list(0)
    --> 3 :: 2 :: 1 :: []
*)

fun factorial (n: int) =
    if n = 0
    then 1
    else n * factorial(n - 1)

fun factorial2 (n: int) =
    product_list(countdown_list n)
