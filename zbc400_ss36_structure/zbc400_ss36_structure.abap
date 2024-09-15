*&---------------------------------------------------------------------*
*& Report ZBC400_SS36_STRUCTURE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc400_ss36_structure.

* Exercise13

PARAMETERS: pa_car  TYPE bc400_s_flight-carrid, "항공사 코드
            pa_con  TYPE bc400_s_flight-connid, "항공편 연결 번호
            pa_date TYPE bc400_s_flight-fldate. "항공편 날짜

DATA: gs_carrier TYPE bc400_s_carrier, "항공사 정보를 저장할 Structure Object
      gs_flight  TYPE bc400_s_flight. "항공편 정보를 저장할 Structure Object

* 구조체 정의
TYPES: BEGIN OF ts_carrierflight,
         carrid     TYPE s_carr_id, "항공사 코드
         carrname   TYPE s_carrname, "항공사 이름
         currcode   TYPE s_currcode, "항공자 통화 코드
         url        TYPE s_carrurl, "웹 사이트 URL
         connid     TYPE s_conn_id, "항공편 연결 번호
         fldate     TYPE s_date, "항공편 날짜
         seatsmax   TYPE s_seatsmax, "최대 좌석 수
         seatsocc   TYPE s_seatsocc, "점유된 좌석 수
         percentage TYPE s_flghtocc, "항공편 점유율

       END OF ts_carrierflight.

DATA gs_carrierflight TYPE ts_carrierflight.

* 항공편 정보를 가져오는 Method
TRY.
    CALL METHOD cl_bc400_flightmodel=>get_flight
      EXPORTING
        iv_carrid = pa_car "입력 받은 항공사 코드
        iv_connid = pa_con "입력 받은 항공편 연결 번호
        iv_fldate = pa_date " 입력 받은 항공편 날짜
      IMPORTING
        es_flight = gs_flight. "가져온 항공편 정보를 gs_flight에 저장
  CATCH cx_bc400_no_data .
  CATCH cx_bc400_no_auth .
ENDTRY.

* 항공사 정보를 가져오는 Method
TRY.
    CALL METHOD cl_bc400_flightmodel=>get_carrier
      EXPORTING
        iv_carrid  = pa_car "입력 받은 항공사 코드
      IMPORTING
        es_carrier = gs_carrier. "가져온 항공사 정보를 gs_carrier에 저장
  CATCH cx_bc400_no_data .
  CATCH cx_bc400_no_auth .
ENDTRY.

* gs_flight 데이터를 gs_carrierflight에 복사
MOVE-CORRESPONDING gs_flight TO gs_carrierflight.
* gs_carrier 데이터를 gs_carrierflight에 복사
MOVE-CORRESPONDING gs_carrier TO gs_carrierflight.

IF gs_carrierflight IS NOT INITIAL. "값이 비어있지 않다면 출력

WRITE:/ 'Airline Code:',gs_carrierflight-carrid.
WRITE:/ 'Airline Name:',gs_carrierflight-carrname.
WRITE:/ 'Flight Connection Number:',gs_carrierflight-connid.
WRITE:/ 'Local currency of airline:',gs_carrierflight-currcode.
WRITE:/ 'Flight date:',gs_carrierflight-fldate.
WRITE:/ 'Flight occupancy:',gs_carrierflight-percentage.
WRITE:/ 'Maximum capacity in economy class:',gs_carrierflight-seatsmax.
WRITE:/ 'Occupied seats in economy class:',gs_carrierflight-seatsocc.
WRITE:/ 'Airline URL:',gs_carrierflight-url+0(32).

ENDIF.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
