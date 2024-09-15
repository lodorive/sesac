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

  "������ / ������ ������ ���� ������ ���
  SELECT *
    FROM spfli
    INTO CORRESPONDING FIELDS OF TABLE it_spfli
    WHERE carrid = pa_car.

  LOOP AT it_spfli INTO wa_spfli.

    "��� ������ ���� ������ ���ٸ�
    IF wa_spfli-countryfr = wa_spfli-countryto.
      wa_spfli-type = 'D'. "������ Ÿ��
    ELSE.
      wa_spfli-type = 'I'. "������ Ÿ��
    ENDIF.
    MODIFY it_spfli FROM wa_spfli.

  ENDLOOP.

  "����ڰ� �������� ���� ���� ���� ���
  IF pa_int <> 'X'.
    "������ �װ��� ����
    DELETE it_spfli WHERE TYPE = 'I'.
  ENDIF.

  "����ڰ� �������� �������� ���� ���
  IF pa_dom <> 'X'.
    "������ �װ��� ����
    DELETE it_spfli WHERE TYPE = 'D'.
  ENDIF.

  "1��) it_spfli�� �̿��Ͽ� sflight ������ �˻�
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

  "2��) it_spfli�� where���� ����ϴ� ���
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

  "��ȣ�� ���̾ƿ�
  gs_layout-excp_fname = 'LIGHT'.
  gs_layout-excp_led = 'X'.

  CLEAR gw_sort.
  gw_sort-fieldname = 'FLDATE'.
  gw_sort-down        = 'X'.
  APPEND gw_sort TO gt_sort.

ENDFORM.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
