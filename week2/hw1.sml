(* #1. Write a function is_older that takes two dates and evaluates to true or false. It evaluates to true if
the first argument is a date that comes before the second argument. (If the two dates are the same,
the result is false.) *)
fun is_older (d1: int*int*int, d2: int*int*int) =
    let
        val year1 = #1 d1
        val year2 = #1 d2
    in
        if (year1 < year2)
        then true

        else if (year1 > year2)
        then false

        else
            let
                val month1 = #2 d1
                val month2 = #2 d2
            in
                if (month1 < month2)
                then true

                else if (month1 > month2)
                then false

                else
                    let
                        val day1 = #3 d1
                        val day2 = #3 d2
                    in
                        day1 < day2
                    end
            end
    end



(* #2. Write a function number_in_month that takes a list of dates and a month (i.e., an int) and returns
how many dates in the list are in the given month. *)
fun number_in_month (dates: (int*int*int) list, month: int) =
    let
        fun check_month (inner_d: (int*int*int) list) =
            if null inner_d
            then [] (* TODO: how to return an option? *)
            else
                if month = #2 (hd inner_d)
                then
                    1 :: check_month(tl inner_d)
                else
                    check_month(tl inner_d)
    in
        length(check_month(dates))
    end



(* #3: take a list of dates and a list of months and returns the number of
dates in the list of dates that are in any of the months in the list of
months. Assume the list of months has no number repeated. *)
fun number_in_months (dates: (int*int*int) list, months: int list) =
    let
        fun innerfn (mths: int list) = 
            if null mths
            then []
            else number_in_month(dates, hd mths) :: innerfn(tl mths)

        fun sum_list_optional (xs: int list) = 
            if null xs
            then NONE
            else
                let
                    val tl_sum = sum_list_optional(tl xs)
                in
                    if isSome(tl_sum)
                    then SOME(hd xs + valOf(tl_sum))
                    else SOME(hd xs)
                end
    in
        let
            val result = sum_list_optional(innerfn(months))
        in
            if isSome result
            then valOf result
            else 0
        end
    end



(* #4: Write a function dates_in_month that takes a list of dates and a month (i.e., an int) and returns a
list holding the dates from the argument list of dates that are in the month. The returned list should
contain dates in the order they were originally given. *)
fun dates_in_month (dates: (int*int*int) list, month: int) =
    let
        fun filterDate (date: int*int*int) =
            if #2 date = month
            then SOME date
            else NONE
    in
        if null dates
        then []
        else
            let
                val filterResult = filterDate(hd dates)
                val remainderResult = dates_in_month (tl dates, month)
            in
                if isSome filterResult
                then (valOf filterResult) :: remainderResult
                else remainderResult
            end
    end



(* #5: Write a function dates_in_months that takes a list of dates and a list of months (i.e., an int list)
and returns a list holding the dates from the argument list of dates that are in any of the months in
the list of months. Assume the list of months has no number repeated. Hint: Use your answer to the
previous problem and SML’s list-append operator (@). *)

fun dates_in_months (dates: (int*int*int) list, months: int list) =
    if null months
    then []
    else dates_in_month(dates, hd months) @ dates_in_months(dates, tl months)



(* #6: Write a function get_nth that takes a list of strings and an int n and returns the nth element of the
list where the head of the list is 1st. Do not worry about the case where the list has too few elements:
your function may apply hd or tl to the empty list in this case, which is okay. *)

fun get_nth (list_of_strings: string list, n: int) =
    if null list_of_strings
    then ""

    else if n = 1
    then hd list_of_strings

    else get_nth(tl list_of_strings, n - 1)



(* #7: Write a function date_to_string that takes a date and returns a string of the form January 20, 2013
(for example). Use the operator ^ for concatenating strings and the library function Int.toString
for converting an int to a string. For producing the month part, do not use a bunch of conditionals.
Instead, use a list holding 12 strings and your answer to the previous problem. For consistency, put a
comma following the day and use capitalized English month names: January, February, March, April,
May, June, July, August, September, October, November, December. *)

fun date_to_string(date: int*int*int) =
    let
        val months = [
            "January", "February", "March",
            "April", "May", "June",
            "July", "August", "September",
            "October", "November", "December"
        ]

        val year = Int.toString(#1 date)
        val month = get_nth(months, #2 date)
        val day =  Int.toString(#3 date)
    in
      month ^ " " ^ day ^ ", " ^ year
    end



(* #8: Write a function number_before_reaching_sum that takes an int called sum, which you can assume
is positive, and an int list, which you can assume contains all positive numbers, and returns an int.
You should return an int n such that the first n elements of the list add to less than sum, but the first
n + 1 elements of the list add to sum or more. Assume the entire list sums to more than the passed in
value; it is okay for an exception to occur if this is not the case. *)

fun number_before_reaching_sum(sum: int, numbers: int list) =
    let
        fun check_sum(acc: int, idx: int, ns: int list) =
            let
                val first_n_sum = acc + hd ns
            in
                if first_n_sum >= sum
                then idx - 1
                else check_sum(first_n_sum, idx + 1, tl ns)
            end
    in
        check_sum(0, 1, numbers)
    end



(* #9. Write a function what_month that takes a day of year (i.e., an int between 1 and 365) and returns
what month that day is in (1 for January, 2 for February, etc.). Use a list holding 12 integers and your
answer to the previous problem. *)
fun what_month (day: int) =
    let
        val list_days = [31,28,31,30,31,30,31,31,30,31,30,31]
        val idx = number_before_reaching_sum(day, list_days)
    in
        print("\nmonth idx: " ^ Int.toString(idx) ^ "\n");
        idx + 1
    end


(* #10. Write a function month_range that takes two days of the year day1 and day2 and returns an int list
[m1,m2,...,mn] where m1 is the month of day1, m2 is the month of day1+1, ..., and mn is the month
of day day2. Note the result will have length day2 - day1 + 1 or length 0 if day1>day2. *)

fun month_range (day1: int, day2: int) =
    if day1 > day2
    then []
    else what_month(day1) :: month_range(day1 + 1, day2)



(* #11. Write a function oldest that takes a list of dates and evaluates to an (int*int*int) option. It
evaluates to NONE if the list has no dates and SOME d if the date d is the oldest date in the list. *)

fun oldest (dates: (int*int*int) list) =
    if null dates
    then NONE
    else
        let
            fun find_oldest (dates: (int*int*int) list) =
                if null (tl dates)
                then hd dates
                else
                    let
                        val oldest_from_tl = find_oldest(tl dates)
                    in
                        (* `is_older` returns true if first date is older *)
                        if is_older(hd dates, oldest_from_tl)
                        then hd dates
                        else oldest_from_tl
                    end
        in
            SOME(find_oldest(dates))
        end



(* #12. Challenge Problem: Write functions number_in_months_challenge and dates_in_months_challenge
that are like your solutions to problems 3 and 5 except having a month in the second argument multiple
times has no more effect than having it once. (Hint: Remove duplicates, then use previous work.) *)



(* #13. Challenge Problem: Write a function reasonable_date that takes a date and determines if it
describes a real date in the common era. A “real date” has a positive year (year 0 did not exist), a
month between 1 and 12, and a day appropriate for the month. Solutions should properly handle leap
years. Leap years are years that are either divisible by 400 or divisible by 4 but not divisible by 100.
(Do not worry about days possibly lost in the conversion to the Gregorian calendar in the Late 1500s.) *)
