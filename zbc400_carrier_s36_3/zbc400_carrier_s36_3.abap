*&---------------------------------------------------------------------*
*& Report ZBC400_CARRIER_S36
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc400_carrier_s36_3.

* SCARR 테이블에서 항공사 코드 AA인 행을 검색해서
* 모든 컬럼을 취득하고자 한다
PARAMETERS pa_car TYPE scarr-carrid.

* 컬럼 5개로 구성된 스트럭쳐 변수
DATA gs_carrier TYPE scarr.

INITIALIZATION.
  "Nothing to do

AT SELECTION-SCREEN.

  PERFORM check_auth. "권한 체크 수행

START-OF-SELECTION.
  PERFORM get_carrier. "항공사 취득함

END-OF-SELECTION.
  PERFORM write_carrier. "항공사 정보를 출력

* 항공사 취득 서브루틴
FORM get_carrier .

  SELECT SINGLE * "mandt carrid carrname currcod url
    FROM scarr
    INTO gs_carrier
   WHERE carrid = pa_car.

ENDFORM.

* 항공사 정보 출력 서브루틴
FORM write_carrier .


    IF gs_carrier IS INITIAL. "값이 없다면

      MESSAGE i001(zmessage_ss36) WITH pa_car.

    ELSE.

      WRITE:/'ID:', gs_carrier-carrid.
      WRITE:/'Name:', gs_carrier-carrname.
      WRITE:/'Currency:', gs_carrier-currcode.

      WRITE:/'URL:', gs_carrier-url+0(32). "0번째 위치에서 32자리를 출력

  ENDIF.

ENDFORM.

* 권한 체크 서브루틴
FORM check_auth .

  AUTHORITY-CHECK OBJECT 'S_CARRID'
         ID 'CARRID' FIELD pa_car
         ID 'ACTVT' FIELD '03'.
  IF sy-subrc <> 0.
    MESSAGE E005(ZMESSAGE_SS36) WITH pa_car.
  ENDIF.

ENDFORM.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
