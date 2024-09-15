*&---------------------------------------------------------------------*
*& Report ZSTRING_S3_3
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZSTRING_S36_4.

PARAMETERS pa_name TYPE string. " 원본 문자열
PARAMETERS pa_find TYPE string. " 찾을 대상 단어
PARAMETERS pa_repl TYPE string. " 변경할 단어

* pa_name에서 pa-find 단어를 찾아서 pa_repl로 바꿈
REPLACE pa_find in pa_name WITH pa_repl IGNORING CASE.

IF sy-subrc = 0.

  WRITE: 'New name if:', pa_name.

ENDIF.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
