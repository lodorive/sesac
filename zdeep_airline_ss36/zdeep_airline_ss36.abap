*&---------------------------------------------------------------------*
*& Report ZDEEP_AIRLINE_SS36
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZDEEP_AIRLINE_SS36.

DATA: gs_airline TYPE ZDEEP_AIRLINE_SS36,
      gw_connections LIKE LINE OF gs_airline-connections.

PARAMETERS pa_car TYPE scarr-carrid.

SELECT SINGLE carrid carrname
  FROM scarr
  INTO CORRESPONDING FIELDS OF gs_airline
  WHERE carrid = pa_car.

  SELECT *
    FROM SPFLI
    INTO CORRESPONDING FIELDS OF TABLE gs_airline-connections
    WHERE carrid = gs_airline-carrid.

WRITE:/ gs_airline-carrid, gs_airline-carrname.

LOOP AT gs_airline-connections INTO gw_connections.

  WRITE:/ gw_connections-connid, gw_connections-countryfr,
  gw_connections-countryto, gw_connections-cityfrom,
  gw_connections-cityto.

  ENDLOOP.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
