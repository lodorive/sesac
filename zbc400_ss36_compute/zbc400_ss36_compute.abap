*&---------------------------------------------------------------------*
*& Report ZBC400_SS36_COMPUTE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZBC400_SS36_COMPUTE.

PARAMETERS pa_int1 TYPE i. "값1
PARAMETERS pa_int2 TYPE i. "값2
PARAMETERS pa_op TYPE c LENGTH 1. "산술연산자

DATA gv_result TYPE p LENGTH 16 DECIMALS 2. "결과 값

IF pa_op = '+' OR
   pa_op = '-' OR
   pa_op = '*' OR
   pa_op = '/' AND pa_int2 <> 0.

  CASE pa_op.
    WHEN '+'.
      gv_result = pa_int1 + pa_int2.
    WHEN '-'.
      gv_result = pa_int1 - pa_int2.
    WHEN '*'.
      gv_result = pa_int1 * pa_int2.
    WHEN '/'.
      gv_result = pa_int1 / pa_int2.
  ENDCASE.

WRITE:/'result:', gv_result.

ELSEIF pa_op = '/' AND pa_int2 = 0.
  WRITE:/ 'Divide by zero not allowed!'.

ELSE.
  WRITE: 'Please use only (+ - * /)'.

ENDIF.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
