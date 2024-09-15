*&---------------------------------------------------------------------*
*& Report ZABAP_JOIN_SS36_2
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zabap_join_ss36_3.

* 화폐 단위를 입력 받음
PARAMETERS pa_cur TYPE zvdb_ss36-currcode.

DATA it_join TYPE TABLE OF zvdb_ss36.

SELECT *
  FROM zvdb_ss36
  INTO TABLE it_join
  WHERE currcode = pa_cur.

cl_demo_output=>display_data( it_join ).

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
