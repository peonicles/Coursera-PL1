(* Helper functions *)
fun countup(n: int) =
    let
        fun innerc(i: int) =
            if i >= n
            then n::[]
            else i :: innerc(i + 1)
    in
        innerc(1)
    end

fun countdown(n: int) =
    if n = 0
    then []
    else n :: countdown(n - 1)



(* makes exponential recursive calls *)
fun bad_max (xs: int list) =
    if null xs
    then 0

    else if null (tl xs)
    then hd xs

    else if hd xs > bad_max(tl xs)
    then hd xs

    else bad_max(tl xs)



(* sum of a empty list isn't 0 *)
fun meh_max (xs: int list) =
    if null xs
    then 0
    else
        (* if 1 element list, return the element *)
        if null (tl xs)
        then hd xs
        else
            (* else calc max of the remainder *)
            let val tl_ans = meh_max(tl xs)
            in
                if hd xs > tl_ans
                then hd xs
                else tl_ans
            end



fun good_max (xs: int list) =
    if null xs
    then NONE
    else
        (* last `max1` call will have empty list param, and will NEVER reach here *)
        (* `tl_ans` on 2nd last call WILL have a result of NONE *)
        (* on 2nd last call `xs` will be a 1 element list, and WILL call `max1` with [] *)
        let val tl_ans = good_max(tl xs)
        in
            (* only time NONE is returned is on the last call *)
            if isSome tl_ans andalso valOf tl_ans > hd xs
            then tl_ans
            else SOME(hd xs)
        end
(* 
max1([1,2,4,3])
--> xs = [1,2,4,3]
    tl_ans = max1([2,4,3])
    --> xs = [2,4,3]
        tl_ans = max1([4,3])
        --> xs = [4,3]
            tl_ans = max1([3])
            --> xs = [3]
                tl_ans = max1([])
                --> xs = []
                    <== returns NONE
                tl_ans = NONE
                if isSome NONE
                <== SOME(3)
            tl_ans = SOME(3)
            if isSome(SOME 3) andalso valOf(SOME 3) > hd [4,3]
            true andalso 3 > 4
            <== SOME(4)
        tl_ans = SOME(4)
        if isSome(SOME 4) andalso valOf(SOME 4) > hd [2,4,3]
        true andalso 4 > 2
        <== SOME(4)
    tl_ans = SOME(4)
    if isSome(SOME 4) andalso valOf(SOME 4) > hd [1,2,4,3]
    true andalso 4 > 1
    <== SOME(4) *)


fun best_max (xs: int list) =
    if null xs
    then NONE (* process empty list immediately, return NONE *)
    else
        let
            (* input will never be [], so inner function can work without using options *)
            (* int list -> int *)
            fun process_non_empty(xs: int list) =
                if null (tl xs) (* base case check, recurse until 1 element list *)
                then
                    hd xs (* base case, return only element *)
                else
                    let
                        val tl_ans = process_non_empty(tl xs)
                    in
                        if hd xs > tl_ans
                        then
                            hd xs
                        else
                            tl_ans
                    end
        in
            SOME(process_non_empty xs)
        end
