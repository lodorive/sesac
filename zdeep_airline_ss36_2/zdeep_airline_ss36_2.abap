*&---------------------------------------------------------------------*
*& Report ZDEEP_AIRLINE_SS36
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZDEEP_AIRLINE_SS36_2.

DATA gs_airline TYPE ZDEEP_AIRLINE_SS36. "구조체 타입 변수 선언
*DATA gw_connections LIKE LINE OF gs_airline-connections.
DATA gw_connections TYPE ZAIRLINE_SS36. "gs_airline에 포함된 connections 타입의 변수 선언

PARAMETERS pa_car TYPE scarr-carrid. "항공사 코드

* 입력 받은 항공사 코드를 이용하여 레코드 조회 후 gs_airline에 저장
SELECT SINGLE *
  FROM scarr
  INTO CORRESPONDING FIELDS OF gs_airline
  WHERE carrid = pa_car.

  " 항공사 코드, 항공사 이름 출력
  WRITE:/ gs_airline-carrid, gs_airline-carrname.

  " gs_airline에 저장되어 있는 항공사 코드로 spfli 레코드 조회 후
  " gs_airline에 포함되어 있는 connections 테이블에 저장
  SELECT *
    FROM SPFLI
    INTO CORRESPONDING FIELDS OF TABLE gs_airline-connections
    WHERE carrid = gs_airline-carrid.

    " gs_airline에 포함된 테이블 gs_airline-connections를 루프하여
    " 각 연결 정보를 출력
    LOOP AT gs_airline-connections INTO gw_connections.

      WRITE:/
      gw_connections-connid,
      gw_connections-countryfr,
      gw_connections-countryto,
      gw_connections-cityfrom,
      gw_connections-cityto.

      ENDLOOP.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
