*&---------------------------------------------------------------------*
*& Report ZSTRING_S3_3
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZSTRING_S36_4.

PARAMETERS pa_name TYPE string. " ���� ���ڿ�
PARAMETERS pa_find TYPE string. " ã�� ��� �ܾ�
PARAMETERS pa_repl TYPE string. " ������ �ܾ�

* pa_name���� pa-find �ܾ ã�Ƽ� pa_repl�� �ٲ�
REPLACE pa_find in pa_name WITH pa_repl IGNORING CASE.

IF sy-subrc = 0.

  WRITE: 'New name if:', pa_name.

ENDIF.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
