*&---------------------------------------------------------------------*
*& Report ZSUBROUTINE_SS36_4
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZSUBROUTINE_SS36_4.

PARAMETERS: pa_num1 TYPE i,
            pa_num2 TYPE i.

DATA gv_result TYPE i.

PERFORM call_add USING pa_num1 pa_num2 "�Ķ���� 2�� ������
                    CHANGING gv_result. "��� ���� �ްڴ�

WRITE:/'Result:', gv_result.
**************************************
FORM call_add USING VALUE(f_1) TYPE i "pa_num1 / ���� ����
                    VALUE(f_2) TYPE i "pa_num2 / ���� ����
                CHANGING f_sum TYPE i. "gv_result / ���� ����

  f_sum = f_1 + f_2.

ENDFORM.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
