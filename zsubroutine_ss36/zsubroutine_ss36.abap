*&---------------------------------------------------------------------*
*& Report ZSUBROUTINE_SS36
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZSUBROUTINE_SS36.

* ȭ�鿡 ���� ID, ������ �α����� ���, ���� ��¥, �ð��� ����ϴ� ���
PERFORM write_basic_info.
PERFORM write_basic_info.

FORM write_basic_info. "�ش� ���α׷��� �� �ڿ� ����
  WRITE:/ 'ID:', sy-uname.
  WRITE:/ 'Lang:', sy-langu.
  WRITE:/ 'Datum:', sy-datum.
  WRITE:/ 'Time', sy-uzeit.
  SKIP.
  ULINE.
ENDFORM.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
