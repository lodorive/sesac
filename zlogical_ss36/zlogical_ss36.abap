*&---------------------------------------------------------------------*
*& Report ZLOGICAL_SS36
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zlogical_ss36.

* 1) 항공사에 대한 화면을 그린다
NODES: spfli, sflight. " spfli와 sfligjt를 가지고 화면을 그리고 싶어요...

* 2) 데이터 취득
GET spfli. " 항공편 가져와라
  WRITE:/ spfli-connid, spfli-countryfr, spfli-countryto.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
