*&---------------------------------------------------------------------*
*& Report ZLOOP_S36_2
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZLOOP_S36_2.

* ȭ�鿡�� ���ڸ� �Է¹޾� 1���� �ش� ���ڱ��� ���� ���ϴ� ���α׷��� ����
PARAMETERS pa_input TYPE i. " ���ڸ� �Է� ����
DATA gv_result TYPE i. " ���� �����ϴ� ����

DO pa_input TIMES.

gv_result = gv_result + sy-index. " 1���� �Է¹��� ���ڱ��� �ݺ��Ͽ� ���ض�

ENDDO.

WRITE: '���: result:', gv_result.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750