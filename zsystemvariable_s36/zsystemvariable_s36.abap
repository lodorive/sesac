*&---------------------------------------------------------------------*
*& Report ZSYSTEMVARIABLE_S36
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZSYSTEMVARIABLE_S36.

WRITE:/ 'today : ', SY-DATUM COLOR COL_POSITIVE.
WRITE:/ 'current time : ', SY-UZEIT COLOR COL_NORMAL.
WRITE:/ 'user-name : ', SY-UNAME COLOR COL_TOTAL.

WRITE:/ icon_checked AS ICON.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
