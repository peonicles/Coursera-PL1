use "hw1.sml";

(* test helpers *)
fun testInt(expected: int, actual: int) = expected = actual
fun testBool(expected: bool, actual: bool) = expected = actual
fun testStr(expected: string, actual: string) = expected = actual
fun testIntList(expected: int list, actual: int list) = expected = actual
fun testDateList(expected: (int*int*int) list, actual: (int*int*int) list) = expected = actual

fun addNumbers(ns: int list) =
   if null (tl ns)
   then hd ns
   else hd ns + addNumbers(tl ns)


(* test data *)
val test_date_1 = (2020, 12, 25)
val test_date_2 = (2020, 2, 28)
val test_date_3 = (2020, 3, 1)
val test_date_4 = (2020, 3, 15)
val dates = [test_date_1, test_date_2, test_date_3, test_date_4]


(* tests *)
(* #1: `is_older` should return true if d1 comes before d2, and false otherwise *)
val ans1_1 = testBool(is_older(test_date_1, test_date_2), false)
val ans1_2 = testBool(is_older(test_date_2, test_date_1), true)
val ans1_3 = testBool(is_older(test_date_2, test_date_2), false)


(* #2: `number_in_month` should take a list of dates and a month, return number of dates that are in month *)
val ans2_0 = testInt(number_in_month([], 1),0)
val ans2_1 = testInt(number_in_month(dates, 12), 1)
val ans2_2 = testInt(number_in_month(dates, 3), 2)
val ans2_3 = testInt(number_in_month(dates, 2), 1)
val ans2_4 = testInt(number_in_month([test_date_2, test_date_2, test_date_3], 2), 2)

(* val a20 = number_in_month_noop(dates, 12) *)
(* val a21 = number_in_month_noop(dates, 3) *)
(* val a22 = number_in_month_noop(dates, 2) *)

(* #3: `number_in_months` should take a list of dates and a list of months and return the number of
   dates in the list of dates that are in any of the months in the list of months.*)
val ans3_01 = testInt(number_in_months([], [2, 12, 3]), 0)
val ans3_02 = testInt(number_in_months(dates, []), 0)
val ans3_1 = testInt(number_in_months(dates, [2]), 1)
val ans3_2 = testInt(number_in_months(dates, [2, 3]), 3)
val ans3_3 = testInt(number_in_months(dates, [2, 12]), 2)
val ans3_4 = testInt(number_in_months(dates, [2, 12, 3]), 4)

(* #4: `dates_in_month` should take a list of dates and a month (i.e., an int) and return a
list holding the dates from the argument list of dates that are in the month. The returned list should
contain dates in the order they were originally given. *)
val ans4_0 = testDateList(dates_in_month([], 3), [])
val ans4_1 = testDateList(dates_in_month(dates, 3), [(2020, 3, 1), (2020, 3, 15)])
val ans4_2 = testDateList(dates_in_month((2020, 2, 14) :: dates, 2), [(2020, 2, 14), (2020, 2, 28)])
val ans4_3 = testDateList(dates_in_month(dates, 12), [(2020, 12, 25)])
val ans4_4 = testDateList(dates_in_month(dates, 7), [])

(* #5: `dates_in_months` takes a list of dates and a list of months and returns a list holding the dates.
Assume the list of months has no number repeated. *)
val ans5_01 = testDateList(dates_in_months([], [2,3]), [])
val ans5_02 = testDateList(dates_in_months(dates, []), [])

val ans5_1 = testDateList(
   dates_in_months(dates, [2,3]),
   [(2020, 2, 28), (2020, 3, 1), (2020, 3, 15)]
)

val ans5_2 = testDateList(
   dates_in_months((2020, 2, 14) :: dates, [2, 12]),
   [(2020, 2, 14), (2020, 2, 28), (2020, 12, 25)]
)

(* #6: `get_nth` should take a list of strings and an int, and return the nth element of the list.
Consider the head of the list as the first element. *)
val ans6_01 = testStr(get_nth([], 999), "")
val ans6_02 = testStr(get_nth(["foo", "bar", "baz"], 999), "")
val ans6_1 = testStr(get_nth(["foo", "bar", "baz"], 2), "bar")
val ans6_2 = testStr(get_nth(["foo", "bar", "baz"], 999), "")

(* #7: `date_to_string` should take a date and return a string of the form January 20, 2013
(for example). *)

val ans7_1 = testStr(date_to_string(test_date_1), "December 25, 2020")
val ans7_2 = testStr(date_to_string(test_date_2), "February 28, 2020")
val ans7_3 = testStr(date_to_string(test_date_3), "March 1, 2020")
val ans7_4 = testStr(date_to_string(test_date_4), "March 15, 2020")

(* #8: `number_before_reaching_sum` should takes a int, and an int list, all of which contain positive numbers, and return an int.
You should return an int n such that the first n elements of the list add to less than sum, but the first n + 1 elements of the list add to sum or more.
Assume the entire list sums to more than the passed in value; it is okay for an exception to occur if this is not the case. *)

val month_list = [31,28,31,30,31,30,31,31,30,31,30,31]
val ans8_1 = testInt(number_before_reaching_sum(2, [1,2,3]), 1)
val ans8_2 = testInt(number_before_reaching_sum(6, [1,2,3,4]), 2)
val ans8_3 = testInt(number_before_reaching_sum(19, [1,2,3,5,8,13,21]), 4)
val ans8_4 = testInt(number_before_reaching_sum(20, [1,2,3,5,8,13,21]), 5)
val ans8_5 = testInt(number_before_reaching_sum(90, month_list), 2)
val ans8_6 = testInt(number_before_reaching_sum(91, month_list), 3)

(* #9. `what_month` should take a day of year (i.e., an int between 1 and 365) and returns what month that day is in (1 for January,
2 for February, etc.). Use a list holding 12 integers and your answer to the previous problem. *)
val ans9_1 = testInt(what_month(90), 3)
val ans9_2 = testInt(what_month(91), 4)
val ans9_3 = testInt(what_month(120), 4)
val ans9_4 = testInt(what_month(121), 5)
val ans9_5 = testInt(what_month(122), 5)
val ans9_6 = testInt(what_month(125), 5)


(* #10. `month_range` should two days of the year day1 and day2 and return an int list
[m1,m2,...,mn] where m1 is the month of day1, m2 is the month of day1+1, ..., and mn is the month
of day2. *)
(* val list_days = [31,28,31,30,31,30,31,31,30,31,30,31] *)
val ans10_1 = testIntList(month_range(100, 1), [])
val ans10_2 = testIntList(month_range(30, 35), [1,1,2,2,2,2])
val ans10_3 = testIntList(month_range(80, 95), [3,3,3,3,3,3,3,3,3,3,3,4,4,4,4,4])


(* #11. `oldest` takes a list of dates and evaluates to an (int*int*int) option. It
evaluates to NONE if the list has no dates and SOME d if the date d is the oldest date in the list. *)
(* val test_date_1 = (2020, 12, 25)
val test_date_2 = (2020, 2, 28)
val test_date_3 = (2020, 3, 1)
val test_date_4 = (2020, 3, 15)
val dates = [test_date_1, test_date_2, test_date_3, test_date_4] *)

val ans11_1 = oldest([]) = NONE
val ans11_2 = oldest([test_date_1]) = SOME test_date_1
val ans11_3 = oldest([(1,2,3),(5,2,3),(7,2,3),(3,2,3)]) = SOME (1,2,3)
val ans11_4 = oldest([(5,5,2),(5,10,2),(5,2,2),(5,12,2)]) = SOME (5,2,2)
val ans11_5 = oldest([(5,12,15),(5,12,10),(5,12,1)]) = SOME (5,12,1)
