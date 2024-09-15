*&---------------------------------------------------------------------*
*& Report  SAPBC430S_ITAB_SORTED                                       *
*&                                                                     *
*&---------------------------------------------------------------------*
*&                                                                     *
*&                                                                     *
*&---------------------------------------------------------------------*

REPORT zbc430_ss36_itab_sorted.

*Exercise3

DATA it_flight TYPE zit_sflight_ss36.
DATA wa_sflight TYPE sflight.

SELECT *
 FROM sflight
 INTO wa_sflight
 WHERE carrid = 'JL'.
  WRITE: / wa_sflight-carrid,
           wa_sflight-connid,
           wa_sflight-fldate,
           wa_sflight-price,
           wa_sflight-currency,
           wa_sflight-planetype.
ENDSELECT.

ULINE.

SELECT *
  FROM sflight
  INTO TABLE it_flight
  WHERE carrid = 'JL'.

LOOP AT it_flight INTO wa_sflight.
  WRITE: / wa_sflight-carrid,
           wa_sflight-connid,
           wa_sflight-fldate,
           wa_sflight-price,
           wa_sflight-currency,
           wa_sflight-planetype.
ENDLOOP.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
