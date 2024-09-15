*&---------------------------------------------------------------------*
*& Report ZABAP_JOIN_SS36_2
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zabap_join_ss36_2.

TYPES:BEGIN OF ts_data,
  carrid TYPE spfli-carrid,
  carrname TYPE scarr-carrname,
  connid TYPE spfli-connid,
  countryfr TYPE spfli-countryfr,
  countryto TYPE spfli-countryto,
  END OF ts_data.

DATA gt_data TYPE TABLE OF ts_data.
DATA gw_data LIKE LINE OF gt_data.

* 화폐 단위를 입력 받음
PARAMETERS pa_cur TYPE scarr-currcode.

SELECT a~carrid
      b~carrname
      a~connid
      a~countryfr
      a~countryto
  FROM spfli AS a
  INNER JOIN scarr AS b
  ON a~carrid = b~carrid
  INTO TABLE gt_data
  WHERE b~currcode = pa_cur.

cl_demo_output=>display_data( gt_data ).

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
