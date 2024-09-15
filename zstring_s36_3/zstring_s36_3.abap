*&---------------------------------------------------------------------*
*& Report ZSTRING_S3_3
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZSTRING_S36_3.

PARAMETERS pa_name TYPE string. " 원본 문자열
PARAMETERS pa_find TYPE string. " 찾을 대상 단어

*FIND pa_find IN pa_name. " 기본 문법(pa_find의 문자를 pa_name에서 찾음)
FIND pa_find IN pa_name IGNORING CASE. " 대소문자 구분 X

IF sy-subrc = 0. " 찾았다
  WRITE 'Found'.
ELSE.
  WRITE 'Not Found'.
ENDIF.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
