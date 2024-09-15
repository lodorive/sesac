FUNCTION zget_connect_ss36.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     REFERENCE(I_CARRID) TYPE  SPFLI-CARRID
*"     REFERENCE(I_CONNID) TYPE  SPFLI-CONNID
*"  EXPORTING
*"     REFERENCE(E_SPFLI) TYPE  SPFLI
*"     VALUE(E_FLIGHTTYPE) TYPE  TEXT
*"  EXCEPTIONS
*"      INVALID_FLIGHT
*"----------------------------------------------------------------------

  SELECT SINGLE *"CITYFROM AIRPFROM CITYTO AIRPTO
    FROM spfli
    INTO E_SPFLI "( E_CITYFROM, E_AIRPFROM, E_CITYTO, E_AIRPTO )
    WHERE carrid = i_carrid.

  IF sy-subrc <> 0.
    "입력한 항공이 존재하지 않는 경우 INVALID_FLIGHT 발생
    RAISE invalid_flight.

  ELSEIF
    E_SPFLI-cityfrom = E_SPFLI-cityto. "출발 국가와 도착 국가가 같다면
    e_flighttype = '국내선'.

  ELSE.
    e_flighttype = '국제선'.

  ENDIF.

ENDFUNCTION.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
