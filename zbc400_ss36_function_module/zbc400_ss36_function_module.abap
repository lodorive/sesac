*&---------------------------------------------------------------------*
*& Report ZBC400_SS36_COMPUTE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc400_ss36_function_module.

TYPES ty_result TYPE p LENGTH 16 DECIMALS 2.

PARAMETERS pa_int1 TYPE i. "값1
PARAMETERS pa_int2 TYPE i. "값2
PARAMETERS pa_op TYPE c LENGTH 1. "산술연산자

DATA gv_result TYPE ty_result. "결과 값


IF pa_op = '+' OR
   pa_op = '-' OR
   pa_op = '*' OR
   pa_op = '/' AND pa_int2 <> 0 OR
   pa_op = '%' OR
   pa_op = 'P'.

  CASE pa_op.
    WHEN '+'.
      gv_result = pa_int1 + pa_int2.
    WHEN '-'.
      gv_result = pa_int1 - pa_int2.
    WHEN '*'.
      gv_result = pa_int1 * pa_int2.
    WHEN '/'.
      gv_result = pa_int1 / pa_int2.
    WHEN '%'.

      PERFORM calc_percentage USING pa_int1 pa_int2
                               CHANGING gv_result.
    WHEN 'P'.

      CALL FUNCTION 'BC400_MOS_POWER'
        EXPORTING
          iv_base               = pa_int1
          iv_power              = pa_int2
        IMPORTING
          ev_result             = gv_result
        EXCEPTIONS
          power_value_too_high  = 1
          result_value_too_high = 2
          OTHERS                = 3.

      CASE sy-subrc.
        WHEN 1.
          MESSAGE i002(zmessage_ss36).
        WHEN 2.
          MESSAGE i003(zmessage_ss36).
        WHEN 3.
          MESSAGE i004(zmessage_ss36).
      ENDCASE.

  ENDCASE.

  WRITE:/'result:', gv_result.

ELSEIF pa_op = '/' AND pa_int2 = 0.
  WRITE:/ 'Divide by zero not allowed!'.

ELSE.
  WRITE: 'Please use only (+ - * / %)'.

ENDIF.


FORM calc_percentage USING VALUE(pv_act) TYPE i
                           VALUE(pv_max) TYPE i
                     CHANGING cv_result TYPE ty_result.
  IF pv_max = 0.
    WRITE:/'Error in percentage calculation'.
  ELSE.
    cv_result = pv_act / pv_max * 100.
  ENDIF.

ENDFORM.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
