*&---------------------------------------------------------------------*
*& Report ZRUNTIME_S36
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZRUNTIME_S36.

* ȭ�鿡�� ���� 2�� �Է� �޾Ƽ� ������ ������ ����
PARAMETERS p_num1 TYPE i.
PARAMETERS p_num2 TYPE i.

DATA gv_result TYPE i. "���� ����� ������ ����

IF p_num2 <> 0. "������ ���� 0�� �ƴ϶�� ���� ������ ���
  gv_result = p_num1 / p_num2.
  WRITE: gv_result.
ELSE."0�̶�� ���� �޽��� ���
  WRITE: 'Divide by zero not allowed!'.
ENDIF.

** �� �ڵ尡 ���� �� �����(���� ��Ȳ�� ���� �˻�)
*IF p_num2 = 0.
*  WRITE: 'Divide by zero not allowed!'.
*  ELSE.
*    gv_result = p_num1 / p_num2.
*  WRITE: gv_result.
*ENDIF.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
