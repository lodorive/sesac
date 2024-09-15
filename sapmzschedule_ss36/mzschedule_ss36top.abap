*&---------------------------------------------------------------------*
*& Include MZSCHEDULE_SS36TOP                                Module Pool      SAPMZSCHEDULE_SS36
*&
*&---------------------------------------------------------------------*
PROGRAM sapmzschedule_ss36.

TABLES: spfli,   "화면 검색 조건 통신 변수
*       sflight  "테이블 컨트롤 통신 변수
        zssflight_ss36."테이블 컨트롤 통신 변수(mark 기능 포함)

DATA: gt_flight TYPE TABLE OF zssflight_ss36,
      gw_flight LIKE LINE OF gt_flight.

CONTROLS my_table TYPE TABLEVIEW USING SCREEN '0100'.

DATA ok_code TYPE sy-ucomm.

DATA gw_col LIKE LINE OF my_table-cols.
DATA gv_fixed TYPE zfixed_ss36.

DATA selline LIKE sy-stepl.
DATA tabix LIKE sy-tabix.

DATA gv_fieldname(32).

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
