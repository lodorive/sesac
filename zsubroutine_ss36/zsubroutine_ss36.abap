*&---------------------------------------------------------------------*
*& Report ZSUBROUTINE_SS36
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZSUBROUTINE_SS36.

* 화면에 본인 ID, 본인이 로그인한 언어, 현재 날짜, 시간을 출력하는 기능
PERFORM write_basic_info.
PERFORM write_basic_info.

FORM write_basic_info. "해당 프로그램의 맨 뒤에 정의
  WRITE:/ 'ID:', sy-uname.
  WRITE:/ 'Lang:', sy-langu.
  WRITE:/ 'Datum:', sy-datum.
  WRITE:/ 'Time', sy-uzeit.
  SKIP.
  ULINE.
ENDFORM.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
