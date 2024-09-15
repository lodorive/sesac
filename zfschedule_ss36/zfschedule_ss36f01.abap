*&---------------------------------------------------------------------*
*&  Include           ZFSCHEDULE_SS36F01
*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*
*&      Form  GET_DATA
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM get_data .

  SELECT SINGLE carrname
    FROM scarr
    INTO gv_name
    WHERE carrid = pa_car.

  SELECT *
  FROM spfli
  INTO TABLE gt_spfli
  WHERE carrid = pa_car.

  CLEAR gs_spfli.
  LOOP AT gt_spfli INTO gs_spfli.

    IF gs_spfli-countryfr <> gs_spfli-countryto. "국제선이라면
      gs_spfli-type = 'I'.
    ELSE.
      gs_spfli-type = 'D'.
    ENDIF.

    MODIFY gt_spfli FROM gs_spfli.

  ENDLOOP.

  "사용자가 국제선을 선택 하지 않은 경우
  IF pa_int <> 'X'.
    "국제선 항공편 삭제
    DELETE gt_spfli WHERE TYPE = 'I'.
  ENDIF.

  "사용자가 국내선을 선택하지 않은 경우
  IF pa_dom <> 'X'.
    "국내선 항공편 삭제
    DELETE gt_spfli WHERE TYPE = 'D'.
  ENDIF.

    IF gt_spfli IS NOT INITIAL.

      SELECT *
      FROM sflight
      INTO TABLE gt_flight
      FOR ALL ENTRIES IN gt_spfli
      WHERE carrid = gt_spfli-carrid
        AND connid = gt_spfli-connid.
      " sflight~carrid = spfli~carrid
      " sflight~connid = spfli~connid

    ENDIF.


  LOOP AT gt_flight INTO gw_flight.
    sflight-carrid = gw_flight-carrid.
  ENDLOOP.

  MOVE-CORRESPONDING gt_flight TO gt_fld.

  LOOP AT gt_fld INTO gs_fld.

    gs_fld-percentage = ( gs_fld-seatsocc / gs_fld-seatsmax ) * 100.

    IF gs_fld-percentage > 80.
      gs_fld-light = '3'.
    ELSE.
      gs_fld-light = '0'.
    ENDIF.

    MODIFY gt_fld FROM gs_fld TRANSPORTING light percentage.

  ENDLOOP.

ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  SET_ALV
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM set_alv .

  gs_layout-excp_fname = 'LIGHT'.
  gs_layout-excp_led = 'X'.

  CLEAR gw_sort.
  gw_sort-fieldname = 'FLDATE'.
  gw_sort-down        = 'X'.
  APPEND gw_sort TO gt_sort.

ENDFORM.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
