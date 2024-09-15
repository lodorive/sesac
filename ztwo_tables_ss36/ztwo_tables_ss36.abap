*&---------------------------------------------------------------------*
*& Report ZTWO_TABLES_SS36
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ztwo_tables_ss36.

* 관련 테이블 SCARR, SPFLI
* 화면에서 화폐 단위를 입력 받아 해당 화폐 단위를 사용하는
* 항공사와 항공편을 출력하시오 (단, 출력 시 항공사 이름도 함께 출력하시오)

TYPES: BEGIN OF ts_conn,
         carrid    TYPE scarr-carrid,
         connid    TYPE spfli-connid,
         countryfr TYPE spfli-countryfr,
         countryto TYPE spfli-countryto,
         carrname  TYPE scarr-carrname,
       END OF ts_conn.

DATA gs_conn TYPE ts_conn.

PARAMETERS p_cur TYPE scarr-currcode. "화폐단위

* 사용자가 입력한 화폐 단위에 맞는
* 항공사 데이터를 선택하여 gs_scarr 변수에 저장
SELECT carrid carrname
  FROM scarr
  INTO CORRESPONDING FIELDS OF gs_conn
  WHERE currcode = p_cur.

  " 선택된 항공사의 carrid와 일치하는 항공편 정보를
  " gs_spfli 변수에 저장
  SELECT connid countryfr countryto
    FROM spfli
    INTO CORRESPONDING FIELDS OF gs_conn
    WHERE carrid = gs_conn-carrid.

    " 선택된 항공사 및 항공편 정보를 출력
    WRITE:/ gs_conn-carrid,         " 항공사 ID
            gs_conn-connid,         " 항공편 ID
            gs_conn-countryfr,     " 출발 국가
            gs_conn-countryto,     " 도착 국가
            gs_conn-carrname.      " 항공사 이름

  ENDSELECT.

ENDSELECT.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
