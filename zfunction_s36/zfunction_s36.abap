*&---------------------------------------------------------------------*
*& Report ZFUNCTION_S36
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZFUNCTION_S36.

* �ܿ� ������ ����ϱ� ���� �Լ� �̸�
* BC100_CALC_HOLS
* �Է� �Ķ���� : 2�� (�� �ް� �ϼ�, ��� �ϼ�)
* ��� �Ķ���� : 1�� (�ܿ� �ް� �ϼ�)

PARAMETERS: p_total TYPE i, "�� �ް� �ϼ�
            p_used TYPE i. "��� �ϼ�

DATA gv_remaining TYPE i. "�ܿ� �ް� �ϼ�

* �Լ� ȣ��(������ �ܿ� �ް� �ϼ��� ����ϴ� �Լ�)
 CALL FUNCTION 'BC100_CALC_HOLS'
   EXPORTING
     iv_total           = p_total "<----
     iv_used            = p_used "<----
  IMPORTING
    EV_REMAINING       = gv_remaining. "---->

WRITE:/ 'Remaining days vacation:', gv_remaining.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
