*&---------------------------------------------------------------------*
*& Report  SAPBC430S_FILL_CLUSTER_TAB                                  *
*&                                                                     *
*&---------------------------------------------------------------------*
*&                                                                     *
*&                                                                     *
*&---------------------------------------------------------------------*

REPORT  zbc430s_fill_cluster_tab                                  .

DATA wa_scarr  TYPE scarr.
DATA wa_spfli  TYPE spfli.
DATA wa_flight TYPE sflight.

DATA my_error TYPE i VALUE 0.


START-OF-SELECTION.

* Replace # by Your user-number and remove all * from here

  DELETE FROM zcarr_ss36.
  DELETE FROM zpfli_ss36.
  DELETE FROM zflight_ss36.


  SELECT * FROM scarr INTO wa_scarr.
    INSERT INTO zcarr_ss36 VALUES wa_scarr.
  ENDSELECT.

  IF sy-subrc = 0.
    SELECT * FROM spfli INTO wa_spfli.
      INSERT INTO zpfli_ss36 VALUES wa_spfli.
    ENDSELECT.

    IF sy-subrc = 0.

      SELECT * FROM sflight INTO wa_flight.
        INSERT INTO zflight_ss36 VALUES wa_flight.
      ENDSELECT.
      IF sy-subrc <> 0.
        my_error = 1.
      ENDIF.
    ELSE.
      my_error = 2.
    ENDIF.
  ELSE.
    my_error = 3.
  ENDIF.

  IF my_error = 0.
    WRITE / 'Data transport successfully finished'.
  ELSE.
    WRITE: / 'ERROR:', my_error.
  ENDIF.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
