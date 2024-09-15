*&---------------------------------------------------------------------*
*& Report ZFORALL_SS36
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zforall_ss36.

* 비행 스케줄 정보에서 국내선만 모두 취득함
DATA it_spfli TYPE TABLE OF spfli.

* SPFLI
SELECT *
  FROM spfli
  INTO TABLE it_spfli
  WHERE countryfr = spfli~countryto.

DATA it_scarr TYPE TABLE OF scarr.

* it_spfli에 속해 있는 모든 항공사를 조회
* it_spfli에서 중복된 항공사 코드는 삭제(OPTIONAL)

* 1) 고려 사항 1번 - OPTIONAL
SORT it_spfli BY carrid.
DELETE ADJACENT DUPLICATES FROM it_spfli COMPARING carrid.

* 2) 고려 사항 2번
* 인터널 테이블이 비어있다면 scarr의 모든 데이터를 가져오므로 확인 해야함
IF it_spfli IS NOT INITIAL.

  SELECT *
    FROM scarr
    INTO TABLE it_scarr
    FOR ALL ENTRIES IN it_spfli " 내부적으로 중복된 데이터가 있다면 하나만 가져옴
    WHERE carrid = it_spfli-carrid. " 중복된 항공사 코드가 있어도 한 번만 취득

ENDIF.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
