*&---------------------------------------------------------------------*
*& Report ZSUBROUTINE_SS36_4
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZSUBROUTINE_SS36_4.

PARAMETERS: pa_num1 TYPE i,
            pa_num2 TYPE i.

DATA gv_result TYPE i.

PERFORM call_add USING pa_num1 pa_num2 "파라미터 2개 던지고
                    CHANGING gv_result. "결과 값을 받겠다

WRITE:/'Result:', gv_result.
**************************************
FORM call_add USING VALUE(f_1) TYPE i "pa_num1 / 복사 전달
                    VALUE(f_2) TYPE i "pa_num2 / 복사 전달
                CHANGING f_sum TYPE i. "gv_result / 원본 전달

  f_sum = f_1 + f_2.

ENDFORM.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
