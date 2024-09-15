*&---------------------------------------------------------------------*
*& Report ZSELECT_LOOP_SS36
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZSELECT_LOOP_SS36.

* 입력 파라미터
PARAMETERS p_cur TYPE S_CURRCODE. "항공사의 화폐단위

* ENDSELECT 사용 시 LOOP를 돌기 때문에
* 스트럭쳐 타입으로 결과 값 담을 공간 만들어야 함
DATA gs_scarr TYPE scarr.

* SELECT SINGLE이 없기 때문에 ENDSELECT로 막아야 한다
* SELECT LOOP (조건에 맞는 데이터만큼 LOOP를 돈다) -> sy-dbcnt
SELECT *
  FROM SCARR
  INTO gs_scarr
  WHERE currcode = p_cur.

  WRITE:/ sy-dbcnt, gs_scarr-carrid, gs_scarr-carrname.
ENDSELECT.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
