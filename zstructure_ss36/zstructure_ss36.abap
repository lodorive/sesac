*&---------------------------------------------------------------------*
*& Report ZSTRUCTURE_SS36
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zstructure_ss36.

* 해당 함수가 리턴하는 값을 모두 보관 할 수 있는
* Local Structure Type을 정의(이름 : TS_RESULT)
* 함수 : ZGET_CARRIER_SS00
* 위의 타입을 이용하여 Structure 변수에 함수 호출을 통해 값을 할당
* 결과 값을 화면에 출력

PARAMETERS p_carrid TYPE s_carr_id. "항공사 코드를 입력 받음

TYPES: BEGIN OF ts_result, "Local Structure Type 정의

         carrid   TYPE s_carr_id,
         carrname TYPE s_carrname,
         currcode TYPE s_currcode,
         url      TYPE s_carrurl,
         ltext    TYPE ltext,

       END OF ts_result.

DATA gs_carr TYPE ts_result. "값을 담을 변수

* 함수를 호출하여 값을 할당
CALL FUNCTION 'ZGET_CARRIER_SS00'
  EXPORTING
    i_carrid   = p_carrid
  IMPORTING
    e_carrid   = gs_carr-carrid
    e_carrname = gs_carr-carrname
    e_currcode = gs_carr-currcode
    e_url      = gs_carr-url
    e_ltext    = gs_carr-ltext
  EXCEPTIONS
    not_found  = 1
    OTHERS     = 2.

* 결과 값 화면에 출력
WRITE:/'carrid : ', gs_carr-carrid.
WRITE:/'carrname : ', gs_carr-carrname.
WRITE:/'currcode : ', gs_carr-currcode.
WRITE:/'url : ', gs_carr-url+0(32).
WRITE:/'langu : ', gs_carr-ltext.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
