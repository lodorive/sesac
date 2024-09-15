*&---------------------------------------------------------------------*
*& Report  BC100_DUMP_RPT
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT ZBC100_S36_DUMP.

PARAMETERS: pa_mths TYPE i,
            pa_hols TYPE i.

DATA: gv_avg_hols TYPE p LENGTH 16 DECIMALS 2.

* Calculate the number of days vacation per month, for the users remaining vacation allowance

IF pa_mths = 0.
  WRITE 'Please ask if you can roll over your remaining vacation'.
ELSE.
  gv_avg_hols = pa_hols / pa_mths.
  WRITE: 'Average days vacation per month remaining is:'(avg), gv_avg_hols.
ENDIF.

*Text elements
*----------------------------------------------------------
* AVG Average days vacation per month remaining is:


*Selection texts
*----------------------------------------------------------
* PA_HOLS         No of days untaken vacation
* PA_MTHS         No of months remaining in year

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
