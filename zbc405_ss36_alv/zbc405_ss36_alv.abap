*&---------------------------------------------------------------------*
*& Report ZBC405_SS36_ALV
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc405_ss36_alv.

*DATA gt_flight TYPE TABLE OF sflight.
*DATA gs_flight LIKE LINE OF gt_flight.

DATA: BEGIN OF gs_flight.
    INCLUDE STRUCTURE sflight.
DATA light(1).
DATA color(4).
DATA changes_possible TYPE icons-text.
DATA: END OF gs_flight.

DATA gt_flight LIKE TABLE OF gs_flight.

DATA ok_code TYPE sy-ucomm.

DATA go_cont TYPE REF TO cl_gui_custom_container.
DATA go_alv TYPE REF TO cl_gui_alv_grid.

DATA gs_variant TYPE disvariant.
DATA gv_save TYPE char01.

DATA gs_layout TYPE lvc_s_layo.

DATA gt_field_cat TYPE lvc_t_fcat.
DATA gs_field_cat TYPE lvc_s_fcat.

* 클래스 정의
CLASS lcl_event_handler DEFINITION.

  PUBLIC SECTION.

    CLASS-METHODS on_double_click
      FOR EVENT double_click
                  OF cl_gui_alv_grid
      IMPORTING es_row_no.

    CLASS-METHODS on_toolbar
      FOR EVENT toolbar
                  OF cl_gui_alv_grid
      IMPORTING e_object.

    CLASS-METHODS on_user_command
      FOR EVENT user_command
                  OF cl_gui_alv_grid
      IMPORTING e_ucomm.

ENDCLASS.

CLASS lcl_event_handler IMPLEMENTATION.

  METHOD on_double_click. "어떤 메소드 구현?

    DATA lv_total TYPE i.
    DATA total_t TYPE c LENGTH 10.
    DATA text_msg TYPE c LENGTH 60.

    READ TABLE gt_flight INTO gs_flight
    INDEX es_row_no-row_id.
*  MESSAGE i018(zmessage_SS36) with gs_flight-connid.

    IF sy-subrc <> 0.
      MESSAGE i075(bc405_408).
    ELSE.
      lv_total = gs_flight-seatsocc +
                 gs_flight-seatsocc_b +
                 gs_flight-seatsocc_f.

      total_t = lv_total.
      text_msg = 'Total number of bookings! ' && total_t.

      MESSAGE text_msg TYPE 'I'.
    ENDIF.

  ENDMETHOD.

  METHOD on_toolbar.

    DATA ls_button TYPE stb_button.

    CLEAR ls_button.
    ls_button-butn_type = 3.
    INSERT ls_button INTO TABLE e_object->mt_toolbar.

    CLEAR ls_button.
    ls_button-function = 'PERCENTAGE'.
    ls_button-text = 'total'.
    ls_button-quickinfo = 'Total economy utilization'.
    ls_button-butn_type = 0.
    INSERT ls_button INTO TABLE e_object->mt_toolbar.

    CLEAR ls_button.
    ls_button-function = 'PERCENTAGE_MARKED'.
    ls_button-text = 'marked'.
    ls_button-quickinfo = 'Economy utilization'.
    ls_button-butn_type = 0.
    INSERT ls_button INTO TABLE e_object->mt_toolbar.


  ENDMETHOD.

  METHOD on_user_command.

    DATA lv_occ TYPE i.
    DATA lv_cap TYPE i.
    DATA lv_percentage TYPE p LENGTH 8 DECIMALS 1.
    DATA lv_text TYPE string.

    DATA lt_selected TYPE lvc_t_roid.
    DATA lw_selected TYPE lvc_s_roid.

    CASE e_ucomm.
      WHEN 'PERCENTAGE'.
        LOOP AT gt_flight INTO gs_flight.
          lv_occ = lv_occ + gs_flight-seatsocc.
          lv_cap = lv_cap + gs_flight-seatsmax.
        ENDLOOP.
        lv_percentage = lv_occ / lv_cap * 100.
        MOVE lv_percentage TO lv_text.
        lv_text = 'Percentage of occupied seats :' && ' ' && lv_text.
        MESSAGE lv_text TYPE 'I'.

      WHEN 'PERCENTAGE_MARKED'.
        CALL METHOD go_alv->get_selected_rows
          IMPORTING
*            et_index_rows =
            et_row_no     = lt_selected.

        IF lines( lt_selected ) > 0.

           LOOP AT lt_selected INTO lw_selected.
             READ TABLE gt_flight INTO gs_flight INDEX lw_selected-row_id.
             lv_occ = lv_occ + gs_flight-seatsocc.
             lv_cap = lv_cap + gs_flight-seatsmax.
           ENDLOOP.

           lv_percentage = lv_occ / lv_cap * 100.
            MOVE lv_percentage TO lv_text.
            lv_text = 'Percentage of occupied seats :' && ' ' && lv_text.
            MESSAGE lv_text TYPE 'I'.
        ELSE.
          MESSAGE 'Please mark at least one row' TYPE 'I'.
        ENDIF.


    ENDCASE.

  ENDMETHOD.

ENDCLASS.


SELECT-OPTIONS so_car FOR gs_flight-carrid MEMORY ID car.
SELECT-OPTIONS so_con FOR gs_flight-connid MEMORY ID con.

SELECTION-SCREEN SKIP 1.
PARAMETERS pa_lv TYPE disvariant-variant.

START-OF-SELECTION.

  SELECT *
  FROM sflight
  INTO CORRESPONDING FIELDS OF TABLE gt_flight
  WHERE carrid IN so_car
    AND connid IN so_con.


  IF gt_flight IS NOT INITIAL.

    LOOP AT gt_flight INTO gs_flight.

      IF gs_flight-fldate(6) = sy-datum(6).
        gs_flight-color = 'C600'.
      ENDIF.

      IF gs_flight-seatsocc = 0.
        gs_flight-light = 1.
      ELSEIF gs_flight-seatsocc < 50.
        gs_flight-light = 2.
      ELSE.
        gs_flight-light = 3.
      ENDIF.

      IF gs_flight-fldate < sy-datum.
        gs_flight-changes_possible = icon_space.
      ELSE.
        gs_flight-changes_possible = icon_okay.
      ENDIF.

      MODIFY gt_flight FROM gs_flight
      TRANSPORTING color light changes_possible.

    ENDLOOP.

    CALL SCREEN 100.
  ENDIF.

  INCLUDE zbc405_ss36_alvo01.
  INCLUDE zbc405_ss36_alvi01.
  INCLUDE zbc405_ss36_alvf01.

*GUI Texts
*----------------------------------------------------------
* T0100 --> Flights


*Messages
*----------------------------------------------------------
*
* Message class: Hard coded
*   Please mark at least one row

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
