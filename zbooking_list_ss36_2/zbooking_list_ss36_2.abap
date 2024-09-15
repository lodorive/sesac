*&---------------------------------------------------------------------*
*& Report ZQUIZ_SS36
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbooking_list_ss36_2.

* 다양한 조건을 입력 받아 해당 일자의 예약 현황을 구현하고자 한다
* 입력 화면 : 항공사 코드(단일값) 항공편(단일값) 비행 일자(범위값)
* 고객 상세 정보는 ZGET_CUSTOMER_SS36 함수 사용
* 비행 클래스는 다국어 처리
* 출력시 항공사 코드(ASC) 비행년도(DESC)+월(DESC) 고객ID(ASC)
* 출력시 취소 예약건은 제외
* 관련 테이블 : SBOOK, SCUSTOM, SCARR

* 2) 변수 정의
DATA: gt_book       TYPE TABLE OF ZBOOKLIST_SS36, "비행 예약 정보 테이블
      gw_book       TYPE ZBOOKLIST_SS36. "비행 예약 정보 구조체

* 3) 검색화면 그리기
PARAMETERS: pa_car TYPE sbook-carrid, "항공사 코드
            pa_con TYPE sbook-connid. "항공편

SELECT-OPTIONS so_fld FOR gw_book-fldate. "일자 선택 옵션

INITIALIZATION.
  PERFORM init. "초기값 설정 서브루틴 호출

AT SELECTION-SCREEN.
  "Nothing to do.

START-OF-SELECTION.
* 데이터 가져오기 함수 호출
CALL FUNCTION 'ZGET_BOOKLIST_SS36'
  EXPORTING
    i_carrid         = pa_car
    i_connid         = pa_con
    i_fldate         = so_fld[]
 IMPORTING
   E_BOOKLIST       = gt_book.

END-OF-SELECTION.
  PERFORM wrtie_data. "예약 정보 출력 서브루틴 호출

FORM init .

  so_fld-sign = 'I'.
  so_fld-option = 'BT'.
  " 현재 날짜의 년도와 월을 추출하여 해당 월의 첫 날로 설정(ex:'202408' + '01')
  so_fld-low = sy-datum+0(6) && '01'. "시작 날짜

  " 달의 마지막 날을 구하기 위해 함수 호출
  CALL FUNCTION 'RP_LAST_DAY_OF_MONTHS'
    EXPORTING
      day_in            = sy-datum   " 현재 날짜를 입력으로 사용
    IMPORTING
      last_day_of_month = so_fld-high.   " 함수에서 반환된 달의 마지막 날을 저장

    APPEND so_fld TO so_fld.

ENDFORM.


FORM wrtie_data .

  " 5) 비행 예약 정보 정렬 및 출력
  SORT gt_book BY carrid ASCENDING
                    fyear DESCENDING
                    fmonth DESCENDING
                    customid ASCENDING.

  LOOP AT gt_book INTO gw_book.

    " 비행 예약 정보 출력
    WRITE:/ gw_book-carrid, " 항공사 코드
            gw_book-carrname, " 항공사 이름
            gw_book-fyear, "비행 일자 년도
            gw_book-fmonth, "비행 일자 월
            gw_book-customid, " 고객 ID
            gw_book-name+0(15), " 고객 이름
            gw_book-telephone+0(20), " 전화번호
            gw_book-email+0(32), " 이메일
            gw_book-classt. "class 텍스트
  ENDLOOP.

ENDFORM.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
