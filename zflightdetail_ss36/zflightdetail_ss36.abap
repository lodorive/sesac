*&---------------------------------------------------------------------*
*& Report ZFLIGHTDETAIL_SS36
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zflightdetail_ss36.

* 입력 : 항공사 코드, 항공편
* 출력 : 출발 국가, 출발 도시, 도착 국가, 도착 도시
*      + 국제선 or 국내선 여부
* 국제선인 경우 : International, 국내선인 경우 : Domestic 리턴
* 예외 : 입력한 항공이 존재하지 않는 경우 INVALID_FLIGHT 발생

PARAMETERS: p_code TYPE spfli-carrid, "항공사 코드
            p_num  TYPE spfli-connid. "항공편

* 함수의 값을 받을 함수
DATA: gs_spfli TYPE spfli,
      gv_data  TYPE text.

CALL FUNCTION 'ZGET_CONNECT_SS36'
  EXPORTING
    i_carrid       = p_code
    i_connid       = p_num
  IMPORTING
    e_spfli        = gs_spfli "spfli 데이터
    e_flighttype   = gv_data "국내선 or 국제선
  EXCEPTIONS
    invalid_flight = 1
    OTHERS         = 2.

IF gv_data = '국내선'. "gv_data가 국내선이라면
  gv_data = 'Domestic'. "Domestic 출력
ELSE. "아니라면
  gv_data = 'International'. "International 출력
ENDIF.

CASE sy-subrc.
  WHEN 0.
    WRITE:/ 'From County:', gs_spfli-countryfr,
            'From City:', gs_spfli-cityfrom,
            'To County:', gs_spfli-countryto,
            'To City:', gs_spfli-cityto,
            '국내 or 국제:', gv_data.

  WHEN 1.
    WRITE:/ 'error'.
  WHEN OTHERS.
ENDCASE.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
