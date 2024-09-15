*&---------------------------------------------------------------------*
*& Report  BC400_RPT_REP_A
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*
REPORT  zbc400_ss36_rep_b.

* Exercise21
CONSTANTS:
     gc_limit_red    TYPE s_flghtocc VALUE 98,
     gc_limit_yellow TYPE s_flghtocc VALUE 75.

DATA:
     gt_flights TYPE bc400_t_flights,
     gs_flight  TYPE bc400_s_flight.

PARAMETERS:
     pa_car TYPE bc400_s_flight-carrid.

* header lineÀ» °¡Áø Internal Table []
SELECT-OPTIONS so_con FOR gs_flight-connid.

INITIALIZATION.
  PERFORM init.

AT SELECTION-SCREEN.
  PERFORM auth-check.

START-OF-SELECTION.
  PERFORM get_data.

END-OF-SELECTION.

  LOOP AT gt_flights INTO gs_flight.
    PERFORM write_flight.
  ENDLOOP.

FORM init .
  pa_car = 'LH'.
ENDFORM.

FORM auth-check .

 TRY.
  CALL METHOD cl_bc400_flightmodel=>check_authority
    EXPORTING
      iv_carrid   = pa_car
      iv_activity = '03'
      .
   CATCH cx_bc400_no_auth .
     MESSAGE E007(ZMESSAGE_SS36) with pa_car.
  ENDTRY.

ENDFORM.

FORM get_data .
  TRY.
CALL METHOD cl_bc400_flightmodel=>get_flights_range
  EXPORTING
    iv_carrid  = pa_car
    it_connid  = so_con[]
  IMPORTING
    et_flights = gt_flights
    .
 CATCH cx_bc400_no_data .
   WRITE:/'Not Found Data!'.
ENDTRY.
ENDFORM.

FORM write_flight .

NEW-LINE.

  IF gs_flight-percentage >= gc_limit_red.
    WRITE: icon_red_light AS ICON.
  ELSEIF gs_flight-percentage >= gc_limit_yellow.
    WRITE: icon_yellow_light AS ICON.
  ELSE.
    WRITE: icon_green_light AS ICON.
  ENDIF.

  WRITE: / gs_flight-carrid COLOR COL_KEY,
           gs_flight-connid COLOR COL_KEY,
           gs_flight-fldate COLOR COL_KEY,
           gs_flight-seatsmax,
           gs_flight-seatsocc,
           gs_flight-percentage.

ENDFORM.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
