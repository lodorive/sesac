*&---------------------------------------------------------------------*
*& Report ZSTRING_S3_3
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZSTRING_S36_3.

PARAMETERS pa_name TYPE string. " ���� ���ڿ�
PARAMETERS pa_find TYPE string. " ã�� ��� �ܾ�

*FIND pa_find IN pa_name. " �⺻ ����(pa_find�� ���ڸ� pa_name���� ã��)
FIND pa_find IN pa_name IGNORING CASE. " ��ҹ��� ���� X

IF sy-subrc = 0. " ã�Ҵ�
  WRITE 'Found'.
ELSE.
  WRITE 'Not Found'.
ENDIF.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
