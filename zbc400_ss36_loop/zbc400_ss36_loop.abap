*&---------------------------------------------------------------------*
*& Report ZBC400_SS36_LOOP
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZBC400_SS36_LOOP.

* Exercise14

DATA: gt_connections TYPE BC400_T_CONNECTIONS, "Table Type(여러 개의 BC400_S_CONNECTION 구조체를 담음)
      gs_connection TYPE BC400_S_CONNECTION. "Structure Type

TRY.
CALL METHOD cl_bc400_flightmodel=>get_connections
  EXPORTING
    iv_carrid      = SPACE "항공사 ID를 빈 값으로 설정 (모든 항공사 데이터 요청)
  IMPORTING
    et_connections = gt_connections "가져온 데이터 gt_connections에 저장
    .
 CATCH cx_bc400_no_data .
   "데이터가 없을 경우 처리
   WRITE:/'No Data Found!'. "데이터가 없음을 사용자에게 알림
 CATCH cx_bc400_no_auth .
   "권한이 없을 경우 처리
   WRITE:/'Authorization Error!'. "권한 오류를 사용자에게 알림
ENDTRY.

*DEPTIME(출발 시간) 기준으로 오름차순으로 정렬
SORT gt_connections BY DEPTIME ASCENDING.

LOOP AT gt_connections INTO gs_connection.
  WRITE:/ 'Airline Code:', gs_connection-carrid. "항공사 코드
  WRITE:/ 'Flight Connection Number:', gs_connection-connid. "항공편 연결 번호
  WRITE:/ 'Departure city:', gs_connection-cityfrom. "출발 도시
  WRITE:/ 'Departure airport:', gs_connection-airpfrom. "출발 공항
  WRITE:/ 'Arrival city:', gs_connection-cityto. "도착 도시
  WRITE:/ 'Destination airport:', gs_connection-airpto. "도착 공항
  WRITE:/ 'Flight time:', gs_connection-fltime. "비행 시간
  WRITE:/ 'Departure time:', gs_connection-deptime. "출발 시간
  WRITE:/ 'Arrival time:', gs_connection-arrtime. "도착 시간
  ULINE. " 하단에 선을 그려서 레코드 구분
ENDLOOP.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
