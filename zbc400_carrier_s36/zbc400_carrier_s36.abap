*&---------------------------------------------------------------------*
*& Report ZBC400_CARRIER_S36
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc400_carrier_s36.

* SCARR 테이블에서 항공사 코드 AA인 행을 검색해서
* 모든 컬럼을 취득하고자 한다
PARAMETERS pa_car TYPE scarr-carrid.

* 컬럼 5개로 구성된 스트럭쳐 변수
DATA gs_carrier TYPE scarr.

* 권한 체크를 위한 변수 설정
DATA gv_auth TYPE c LENGTH 1.

PERFORM get_carrier. "항공사 취득함
PERFORM write_carrier. "항공사 정보를 출력

FORM get_carrier .

  SELECT SINGLE * "mandt carrid carrname currcod url
    FROM scarr
    INTO gs_carrier
   WHERE carrid = pa_car.

  " 값이 있는지부터 확인
  IF sy-subrc <> 0. " 값이 없다면
    CLEAR gs_carrier.
  ELSE. "값이 있다면

    "권한 체크
    AUTHORITY-CHECK OBJECT 'S_CARRID'
             ID 'CARRID' FIELD pa_car
             ID 'ACTVT' FIELD '03'.

    IF sy-subrc <> 0. "권한이 없다면
      gv_auth = 'f'. "false 값을 넣어줌
    ENDIF.

  ENDIF.

ENDFORM.

FORM write_carrier .

  IF gv_auth = 'f'. "권한이 없다면
    MESSAGE i005(zmessage_s36) WITH pa_car.

  ELSE.

    IF gs_carrier IS INITIAL.
      MESSAGE i007(zmssage_s36) WITH pa_car.
    ELSE.
      WRITE:/'ID:', gs_carrier-carrid.
      WRITE:/'Name:', gs_carrier-carrname.
      WRITE:/'Currency:', gs_carrier-currcode.

      WRITE:/'URL:', gs_carrier-url+0(32). "0번째 위치에서 32자리를 출력
    ENDIF.
  ENDIF.
ENDFORM.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
