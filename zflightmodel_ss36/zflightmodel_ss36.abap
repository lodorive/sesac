*&---------------------------------------------------------------------*
*& Report ZFLIGHTMODEL_SS36
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zflightmodel_ss36.

* 화면에서 항공사 코드와 항공편을 입력받아 해당 비행편을 출력하는 프로그램을 구현
* 사용할 함수 -> BC400_DDS_FLIGHTLIST_GET

*출력 전용 인터널 테이블 필요(gt_flight 모든 컬럼 + FREE 컬럼)
* 1)스트럭쳐 타입 정의
TYPES BEGIN OF ts_output.
"gt_flight의 line 타입을 모두 포함
    INCLUDE STRUCTURE bc400_s_flight.
TYPES: free TYPE bc400_s_flight-seatsmax.
TYPES END OF ts_output.

* 입력 파라미터
PARAMETERS: p_carrid TYPE bc400_s_flight-carrid, "항공사 코드
            p_connid TYPE bc400_s_flight-connid. "항공편 연결 번호

DATA gt_flights TYPE bc400_t_flights. "여러 비행편 정보를 담을 내부 테이블
DATA gw_flight LIKE LINE OF gt_flights. "Work Area

* 출력 전용 인터널 테이블
DATA gt_outputs TYPE TABLE OF ts_output.
DATA gw_output LIKE LINE OF gt_outputs.

* 비행편 리스트를 가져오는 함수
CALL FUNCTION 'BC400_DDS_FLIGHTLIST_GET'
  EXPORTING
    iv_carrid  = p_carrid "입력 받은 항공사 코드
    iv_connid  = p_connid "입력 받은 항공편 연결 번호
  IMPORTING
    et_flights = gt_flights "가져온 비행편 리스트를 저장
  EXCEPTIONS
    no_data    = 1
    OTHERS     = 2.

IF sy-subrc <> 0.

  WRITE:/'Error occurred while fetching flight data!'.

ELSE.

MOVE-CORRESPONDING gt_flights TO gt_outputs. "함수의 결과를 gt_outputs으로

* 잔여 좌석 수 계산
LOOP AT gt_outputs INTO gw_output.
  gw_output-free = gw_output-seatsmax - gw_output-seatsocc.
  MODIFY gt_outputs FROM gw_output.
ENDLOOP.

* 항공사 코드, 항공편 연결 번호, 비행 날짜 기준으로 정렬(내림차순)
SORT gt_outputs BY carrid connid fldate DESCENDING.

LOOP AT gt_outputs INTO gw_output.

  "각 비행편의 세부 정보를 출력
  WRITE:/
  gw_output-carrid,   "항공사 코드
  gw_output-connid,   "항공편 연결 번호
  gw_output-fldate,   "비행 날짜
  gw_output-seatsmax, "최대 좌석 수
  gw_output-seatsocc, "점유된 좌석 수
  gw_output-free,            "여유 좌석 수
  gw_output-percentage. "비행편 점유율

ENDLOOP.

ENDIF.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
