*&---------------------------------------------------------------------*
*& Report ZEVENT_BLOCK_SS36
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zevent_block_ss36.

* 항공사 코드(단일 검색) -> scarr
* 항공 일자(범위 검색) -> sflight

DATA gs_flight TYPE sflight.

PARAMETERS pa_car TYPE scarr-carrid.
SELECT-OPTIONS so_fdt FOR gs_flight-fldate.

LOAD-OF-PROGRAM.
  " 주로 펑션 그룹에서 사용 됨(INITIALIZATION. 와 겹침)
  " 순서는 LOAD-OF-PROGRAM 먼저 실행 됨

INITIALIZATION.

  PERFORM init. "서브루틴 호출

AT SELECTION-SCREEN.
  " 사용자 입력 값 (1000번 화면) or 권한 체크
  " AA 항공사 폐쇄로 사용 못하게 하고자 함
   IF pa_car = 'AA'.
    " 무조건 메세지 E를 사용해야 함 = START-OF-SELECTION으로 이동을 못하게 함.
     MESSAGE E006(ZMESSAGE_SS36) WITH pa_car.
   ENDIF.

START-OF-SELECTION.
  " 데이터 취득 부
  WRITE: 'Done.....'.

END-OF-SELECTION.
  " 데이터 출력 부

*&---------------------------------------------------------------------*
*&      Form  INIT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM init .

  " 초기화 로직(전역 변수 or 1000번 화면 초기화)
  " 1) 화면이 뜨자마자 UA로 설정
    pa_car = 'UA'.

  " 2) 화면이 뜨자마자 시작일은 오늘, 종료일은 +30일로 설정
    so_fdt-sign = 'I'.
    so_fdt-option = 'BT'.
    so_fdt-low = sy-datum.
    so_fdt-high = sy-datum + 30.
*    APPEND so_fdt TO so_fdt.
    APPEND so_fdt. "이름이 같으면 생략 가능

ENDFORM.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
