(* 3-let-expressions.sml *)
(* let expressions *)
(* local bindings *)

val a = 10
(* int -> int *)
fun silly1() =
    let
        val x = if a > 0 then 100 else 0 (* 100 *)
        (* y has access to a outside the function, and x in previous binding *)
        val y = a + x + 100000 (* 100110 *)
    in
        x + y
    end

val s1 = silly1() (* 100210 *)

fun silly2() =
    let
        val x = 1
    in
        (let val x = 100 in x + 1 end) + (* x is shadowed, expression returns 101 *)
        (let val y = x + 2 in y + 1 end) (* expression returns 4 *)
    end

val s2 = silly2() (* 105 *)


(* count from range [from, to) *)
(* 3, 6 -> [3,4,5] *)
fun count(from: int, to: int) =
    if from = to
    then []
    else from :: count(from + 1, to)

(* count from range [from, to] *)
(* 3, 6 -> [3, 4, 5, 6] *)
fun count_v2(from: int, to: int) =
    if from = to
    then to :: []
    else from :: count_v2(from + 1, to)

(* count from range [from, to] *)
(* 3, 6 -> [3, 4, 5, 6] *)
fun count_v3(from: int, to: int) =
    if from = to + 1
    then []
    else from :: count_v3(from + 1, to)

(* give a number N, get a list with that number counting from 1 to N *)
(* 3 -> [1,2,3] *)
fun countupfrom1(n: int) =
    count_v2(1, n)

(* now we can inline the count function inside another function using a let expression.
   The `to` parameter is redundant and is removed *)
fun countup(n: int) =
    let
        fun innerc(i: int) =
            if i >= n
            then n::[]
            else i :: innerc(i + 1)
    in
        innerc(1)
    end


(* countdown *)
fun countdown(n: int) =
    if n = 0
    then []
    else n :: countdown(n - 1)

(* Find the biggest number in a list *)
fun bad_max (xs: int list) =
    if null xs
    then 0

    (* if 1 element list, return the element *)
    else if null (tl xs)
    then hd xs

    (* if head greater than tail of list, return head *)
    else if hd xs > bad_max(tl xs)
    then hd xs

    (* else return max of tail *)
    else bad_max(tl xs)



(* Find the biggest number in a list *)
fun good_max (xs: int list) =
    if null xs
    then 0

    (* if 1 element list, return the element *)
    else if null(tl xs)
    then hd xs

    else
        let
            (* cache the value of previous calls in a variable *)
            val tail_max = good_max(tl xs)
        in
            (* if head greater than tail of list, return head *)
            if hd xs > tail_max
            then hd xs
            (* else return max of tail *)
            else tail_max
        end
