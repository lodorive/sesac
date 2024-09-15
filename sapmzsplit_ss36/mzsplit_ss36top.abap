*&---------------------------------------------------------------------*
*& Include MZSPLIT_SS36TOP                                   Module Pool      SAPMZSPLIT_SS36
*&
*&---------------------------------------------------------------------*
PROGRAM SAPMZSPLIT_SS36.

TABLES: SCARR.
DATA ok_code TYPE sy-ucomm.

*스플릿 컨테이너를 위한 변수
"go_split <--> 화면의 Splitter랑 연결 시켜줘야 함
DATA go_split TYPE REF TO cl_dynpro_splitter.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
