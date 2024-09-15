REPORT ztwo_tables_ss36_2.

* 관련 테이블 SCARR, SPFLI
* 화면에서 화폐 단위를 입력 받아 해당 화폐 단위를 사용하는
* 항공사와 항공편을 출력하시오 (단, 출력 시 항공사 이름도 함께 출력하시오)

PARAMETERS p_cur TYPE scarr-currcode. "화폐단위

* scarr과 spfli의 테이블 구조와 내부 테이블 선언
DATA gs_scarr TYPE scarr. " 항공사 테이블 구조
DATA gt_scarr LIKE TABLE OF gs_scarr.
DATA gs_spfli TYPE spfli. " 항공편 테이블 구조
DATA gt_spfli LIKE TABLE OF gs_spfli.

* 사용자가 입력한 화폐 단위에 맞는
* 항공사 데이터를 선택하여 gt_scarr 내부 테이블에 저장
SELECT carrid carrname
  FROM scarr
  INTO CORRESPONDING FIELDS OF TABLE gt_scarr
  WHERE currcode = p_cur.

* gt_scarr 내부 테이블에서 항공사 정보를 하나씩 읽어옴
LOOP AT gt_scarr INTO gs_scarr.

  " 현재 읽은 항공사의 carrid와 일치하는 항공편 정보를
  " gt_spfli 내부 테이블에 저장
  SELECT connid countryfr countryto
  FROM spfli
  INTO CORRESPONDING FIELDS OF TABLE gt_spfli
  WHERE carrid = gs_scarr-carrid.

  " gt_spfli 내부 테이블에서 항공편 정보를 하나씩 읽어옴
  LOOP AT gt_spfli INTO gs_spfli.

    WRITE:/ gs_scarr-carrid,         " 항공사 ID
            gs_spfli-connid,         " 항공편 ID
            gs_spfli-countryfr,     " 출발 국가
            gs_spfli-countryto,     " 도착 국가
            gs_scarr-carrname.      " 항공사 이름

  ENDLOOP.

ENDLOOP.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
