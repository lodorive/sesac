*&---------------------------------------------------------------------*
*& Report  BC100_DEBUG_RPT
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT ZBC100_S36_DEBUG.

PARAMETERS: pa_name TYPE string,    "Input field for users name
            pa_total TYPE i,        "Total days annual vacation
            pa_used TYPE i,         "Number of days vacation already used
            pa_roll TYPE i.         "Number of days vacation to roll over to next year

DATA gv_remaining TYPE i.           "Variable to hold remaining days vacation for the year
DATA gv_next_year TYPE i.           "Variable to hold number of days vacation for next year
DATA gv_month_avg TYPE p LENGTH 16 DECIMALS 2.    "Variable to hold average days vacation per month
CONSTANTS c_months TYPE i VALUE 12. "Constant for total months in a year

* Calculate remaining days vacation for the year

gv_remaining = pa_total - pa_used.

* Calculate total vacation for next year, including days rolled over

gv_next_year = pa_total + pa_roll.

* Calculate the average number of days vacation per month

gv_month_avg = pa_total / c_months.

* Output details

WRITE: gv_remaining, 'days vacation remaining for'(rem), pa_name.
WRITE:/ pa_used, 'days vacation will be available next year'(nxt).
WRITE:/ gv_month_avg, 'days vacation on average per month'(avg).

*Text elements
*----------------------------------------------------------
* AVG days vacation on average per month
* NXT days vacation will be available next year
* REM days vacation remaining for


*Selection texts
*----------------------------------------------------------
* PA_NAME         Employee Name
* PA_ROLL         Vacation Days to Rollover
* PA_TOTAL         Total Annual Vacation Days
* PA_USED         Taken Vacation Days

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
