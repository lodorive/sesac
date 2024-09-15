*&---------------------------------------------------------------------*
*& Report ZQUIZ_SS36
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zquiz_ss36.

* 다양한 조건을 입력 받아 해당 일자의 예약 현황을 구현하고자 한다
* 입력 화면 : 항공사 코드(단일값) 항공편(단일값) 비행 일자(범위값)
* 고객 상세 정보는 ZGET_CUSTOMER_SS36 함수 사용
* 비행 클래스는 다국어 처리
* 출력시 항공사 코드(ASC) 비행년도(DESC)+월(DESC) 고객ID(ASC)
* 출력시 취소 예약건은 제외
* 관련 테이블 : SBOOK, SCUSTOM, SCARR

* 1) TYPE 정의
TYPES: BEGIN OF ts_flight, "
         carrid    TYPE scarr-carrid,      " 항공사 코드
         carrname  TYPE scarr-carrname,    " 항공사 이름
         fldate    TYPE sbook-fldate,      " 비행 일자
         customid  TYPE scustom-id,        " 고객 ID
         name      TYPE scustom-name,      " 고객 이름
         telephone TYPE scustom-telephone, " 고객 전화번호
         email     TYPE scustom-email,     " 고객 이메일
         class     TYPE sbook-class,       " 좌석 클래스
         cancelled TYPE sbook-cancelled,   " 예약 취소 여부
       END OF ts_flight.


* 2) 변수 정의
DATA: gt_flight     TYPE TABLE OF ts_flight, "비행 예약 정보 테이블
      gs_flight     TYPE ts_flight, "비행 예약 정보 구조체
      lv_datum_low  TYPE sy-datum, "달의 첫 날을 담을 변수
      lv_datum_high TYPE sy-datum. "달의 마지막 날을 담을 변수

* 3) 입력 값
PARAMETERS: pa_car TYPE scarr-carrid, "항공사 코드
            pa_con TYPE sbook-connid. "항공편

SELECT-OPTIONS so_fld FOR gs_flight-fldate. "비행 일자 선택 옵션


INITIALIZATION.
  PERFORM init. "초기값 설정 서브루틴 호출

START-OF-SELECTION.
  PERFORM get_data. "데이터 가져오기 서브루틴 호출

END-OF-SELECTION.
  PERFORM wrtie_flight. "비행 예약 정보 출력 서브루틴 호출

FORM init .
  " 현재 날짜를 변수에 저장
  lv_datum_high = sy-datum.

  " 달의 마지막 날을 구하기 위해 함수 호출
  CALL FUNCTION 'RP_LAST_DAY_OF_MONTHS'
    EXPORTING
      day_in            = lv_datum_high   " 현재 날짜를 입력으로 사용
    IMPORTING
      last_day_of_month = lv_datum_high.   " 함수에서 반환된 달의 마지막 날을 변수에 저장

  " 달의 첫 날을 구하기
  " 현재 날짜의 년도와 월을 추출하여 해당 월의 첫 날로 설정(ex:'202408' + '01')
  lv_datum_low = lv_datum_high+0(6) && '01'.

  so_fld-sign = 'I'.
  so_fld-option = 'BT'.
  so_fld-low = lv_datum_low. "시작 날짜
  so_fld-high = lv_datum_high. "종료 날짜

  APPEND so_fld TO so_fld. "비행 일자 선택 옵션에 추가

ENDFORM.

FORM get_data .

  " 4) 데이터 취득
  " 입력 받은 항공사 코드, 항공편, 비행 일자 기준으로 예약 정보 조회
  SELECT carrid fldate customid class cancelled
     FROM sbook
     INTO CORRESPONDING FIELDS OF gs_flight
     WHERE carrid = pa_car
     AND connid = pa_con
     AND fldate IN so_fld.

    " 항공사 이름 조회
    SELECT carrname
      FROM scarr
      INTO CORRESPONDING FIELDS OF gs_flight
      WHERE carrid = gs_flight-carrid.

      " 고객 정보를 조회하기 위한 함수 호출
      CALL FUNCTION 'ZGET_CUSTOMER_SS36'
        EXPORTING
          i_id        = gs_flight-customid
        IMPORTING
          e_name      = gs_flight-name
          e_telephone = gs_flight-telephone
          e_email     = gs_flight-email.

      " 비행 예약 정보 테이블에 추가
      APPEND gs_flight TO gt_flight.

    ENDSELECT.
  ENDSELECT.

ENDFORM.

FORM wrtie_flight .

  " 5) 비행 예약 정보 정렬 및 출력
  SORT gt_flight BY carrid ASCENDING
                    fldate DESCENDING
                    customid ASCENDING.

  LOOP AT gt_flight INTO gs_flight.

    " 예약이 취소되지 않은 경우에만
    IF gs_flight-cancelled <> 'X'.

      " 비행 예약 정보 출력
     WRITE:/ gs_flight-carrid, " 항공사 코드
             gs_flight-carrname, " 항공사 이름
             gs_flight-fldate+0(4), " 년
             gs_flight-fldate+4(2), " 월
             gs_flight-customid, " 고객 ID
             gs_flight-name+0(15), " 고객 이름
             gs_flight-telephone+0(20), " 전화번호
             gs_flight-email. " 이메일

      " 비행 클래스에 따른 출력(Text Symbol)
      CASE gs_flight-class.
        WHEN 'F'.
          WRITE: TEXT-001.
        WHEN 'Y'.
          WRITE: TEXT-002.
        WHEN 'C'.
          WRITE: TEXT-003.
      ENDCASE.

    ENDIF.

  ENDLOOP.

ENDFORM.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
