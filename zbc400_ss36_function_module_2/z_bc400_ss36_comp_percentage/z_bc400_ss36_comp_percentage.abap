FUNCTION Z_BC400_SS36_COMP_PERCENTAGE.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     REFERENCE(IV_ACT) TYPE  BC400_ACT
*"     REFERENCE(IV_MAX) TYPE  BC400_MAX
*"  EXPORTING
*"     REFERENCE(EV_PERCENTAGE) TYPE  BC400_PERC
*"  EXCEPTIONS
*"      DIVISION_BY_ZERO
*"----------------------------------------------------------------------


IF iv_max = 0.
  ev_percentage = 0.
  RAISE DIVISION_BY_ZERO.
ELSE.

  ev_Percentage = iv_act / iv_max * 100.

ENDIF.


ENDFUNCTION.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
