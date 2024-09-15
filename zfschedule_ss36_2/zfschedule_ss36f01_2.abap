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

  "국제선 / 국내선 구분을 위한 데이터 취득
  SELECT *
    FROM spfli
    INTO CORRESPONDING FIELDS OF TABLE it_spfli
    WHERE carrid = pa_car.

  LOOP AT it_spfli INTO wa_spfli.

    "출발 국가와 도착 국가가 같다면
    IF wa_spfli-countryfr = wa_spfli-countryto.
      wa_spfli-type = 'D'. "국내선 타입
    ELSE.
      wa_spfli-type = 'I'. "국제선 타입
    ENDIF.
    MODIFY it_spfli FROM wa_spfli.

  ENDLOOP.

  "사용자가 국제선을 선택 하지 않은 경우
  IF pa_int <> 'X'.
    "국제선 항공편 삭제
    DELETE it_spfli WHERE TYPE = 'I'.
  ENDIF.

  "사용자가 국내선을 선택하지 않은 경우
  IF pa_dom <> 'X'.
    "국내선 항공편 삭제
    DELETE it_spfli WHERE TYPE = 'D'.
  ENDIF.

  "1안) it_spfli를 이용하여 sflight 데이터 검색
*  LOOP AT it_spfli INTO wa_spfli.
*
*    SELECT *
*      FROM sflight
*      APPENDING
*      CORRESPONDING FIELDS OF TABLE it_fld
*      WHERE carrid = wa_spfli-carrid
*        AND connid = wa_spfli-connid.
*
*  ENDLOOP.

  "2안) it_spfli를 where절에 사용하는 방법
    SELECT *
      FROM sflight
      INTO
      CORRESPONDING FIELDS OF TABLE it_fld
      FOR ALL ENTRIES IN it_spfli
      WHERE carrid = it_spfli-carrid
      AND connid = it_spfli-connid.

*  SELECT SINGLE carrname
*    FROM scarr
*    INTO gv_name
*    WHERE carrid = pa_car.

*  SELECT *
*  FROM sflight
*  INTO TABLE gt_flight
*  WHERE carrid = pa_car.
*
*  LOOP AT gt_flight INTO gw_flight.
*    sflight-carrid = gw_flight-carrid.
*  ENDLOOP.
*
*  MOVE-CORRESPONDING gt_flight TO gt_fld.

  LOOP AT it_fld INTO wa_fld.

    wa_fld-percentage = ( wa_fld-seatsocc / wa_fld-seatsmax ) * 100.

    IF wa_fld-percentage > 80.
      wa_fld-light = '3'.
    ELSE.
      wa_fld-light = '0'.
    ENDIF.

    MODIFY it_fld FROM wa_fld TRANSPORTING light percentage.

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

  "신호등 레이아웃
  gs_layout-excp_fname = 'LIGHT'.
  gs_layout-excp_led = 'X'.

  CLEAR gw_sort.
  gw_sort-fieldname = 'FLDATE'.
  gw_sort-down        = 'X'.
  APPEND gw_sort TO gt_sort.

ENDFORM.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
