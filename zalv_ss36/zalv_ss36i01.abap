*&---------------------------------------------------------------------*
*&  Include           ZREPORT_SS36I01
*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0100 INPUT.

  CASE ok_code.
    WHEN 'BCAN'. "화면의 모든 예약을 취소 처리 함
      LOOP AT gt_book INTO gw_book WHERE cancelled = space.
        gw_book-cancelled = 'X'.
        MODIFY gt_book FROM gw_book TRANSPORTING cancelled.
      ENDLOOP.

      "ALV에게 화면 갱신 요청
      CALL METHOD go_alv->refresh_table_display
        EXPORTING
          is_stable      = gs_stable " 가로/세로 스크롤바를 고정
*          i_soft_refresh = " 필터 or 정렬을 유지하고 화면을 다시 그럴건지
        EXCEPTIONS
          finished       = 1
          others         = 2.

      MESSAGE i016(zmessage_ss36).

    WHEN 'BACK' OR 'EXIT'.
      PERFORM free_control_resources. "자원(Container, ALV 객체)을 반납
      "이전 화면(1000)으로 이동
      LEAVE TO SCREEN 0.
    WHEN 'CANC'.
      LEAVE PROGRAM.
  ENDCASE.

ENDMODULE.
*&---------------------------------------------------------------------*
*&      Form  FREE_CONTROL_RESOURCES
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM free_control_resources .

* 생성 : 부모 -> 자식
* 파괴 : 자식 -> 부모

  CALL METHOD go_alv->free
    EXCEPTIONS
      cntl_error        = 1
      cntl_system_error = 2
      OTHERS            = 3.

  CALL METHOD go_cont->free
    EXCEPTIONS
      cntl_error        = 1
      cntl_system_error = 2
      OTHERS            = 3.

* 레퍼런스 변수 초기화
  CLEAR: go_alv, go_cont.

ENDFORM.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
