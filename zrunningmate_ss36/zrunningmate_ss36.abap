*&---------------------------------------------------------------------*
*& Report ZRUNNINGMATE_SS36
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zrunningmate_ss36.

TYPES: BEGIN OF ts_output,
         carrid     TYPE spfli-carrid,
         connid     TYPE spfli-connid,
         carrname   TYPE scarr-carrname,
         countryfr  TYPE spfli-countryfr,
         countryto  TYPE spfli-countryto,
         fldate     TYPE sflight-fldate,
         price      TYPE sflight-price,
         flight_int TYPE c LENGTH 6,
       END OF ts_output.

DATA gs_output TYPE ts_output.
DATA gt_output TYPE TABLE OF ts_output.

SELECT-OPTIONS so_car FOR gs_output-carrid.
SELECT-OPTIONS so_con FOR gs_output-connid.
PARAMETERS pa_from TYPE spfli-airpfrom.

INITIALIZATION.

AT SELECTION-SCREEN.

START-OF-SELECTION.

  SELECT *
    FROM spfli
    INTO CORRESPONDING FIELDS OF TABLE gt_output
    WHERE carrid IN so_car
    AND connid IN so_con
    AND airpfrom = pa_from.

  LOOP AT gt_output INTO gs_output.

    SELECT SINGLE carrname
      FROM scarr
      INTO CORRESPONDING FIELDS OF gs_output
      WHERE carrid = gs_output-carrid.

    IF gs_output-countryfr <> gs_output-countryto.
      gs_output-flight_int = '국제선'.
    ELSE.
      gs_output-flight_int = '국내선'.
    ENDIF.

    SELECT SINGLE fldate price
      FROM sflight
      INTO CORRESPONDING FIELDS OF gs_output
      WHERE carrid = gs_output-carrid.

    MODIFY gt_output FROM gs_output.

  ENDLOOP.

  SORT gt_output BY price DESCENDING.

  LOOP AT gt_output INTO gs_output.

    WRITE:/ gs_output-carrid,
            gs_output-carrname,
            gs_output-countryfr,
            gs_output-countryto,
            gs_output-fldate,
            gs_output-price,
            gs_output-flight_int.

  ENDLOOP.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
