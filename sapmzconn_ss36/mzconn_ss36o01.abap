*&---------------------------------------------------------------------*
*&  Include           MZCONN_SS36O01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  STATUS_0100  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE status_0100 OUTPUT.
  SET PF-STATUS 'S0100'.
  SET TITLEBAR 'T0100'. "타이틀 바
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  INIT  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE init OUTPUT.

*  SET/GET으로 대체
*  IF spfli-carrid IS INITIAL.
*    spfli-carrid = 'AA'.
*  ENDIF.

* 커서 위치를 io_command에 위치 시킴(무조건 대문자로)
*  SET CURSOR FIELD 'IO_COMMAND'.

ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  MODIFY_SCREEN  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE modify_screen OUTPUT.

  CASE io_command.
    WHEN 'D'. "조회 모드

      LOOP AT SCREEN. "Work Area 필요 없음
        "현재 SCREEN에는 200번 화면의 모든 요소가 담겨있음
        IF screen-group1 = 'XYZ'.
          "입력 불가로 만들어라
          screen-input = 0. "1:입력 가능 / 0:입력 불가
        ENDIF.

        MODIFY SCREEN. "잊지말고 무조건
      ENDLOOP.

    WHEN 'U'. "수정 모드
      "화면을 설계시 수정모드로 설계했기 때문에 굳이 로직이 필요 없음
  ENDCASE.

ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  STATUS_0200  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE status_0200 OUTPUT.
  DATA fcode TYPE TABLE OF sy-ucomm. "비활성화 시킬 기능(action)을 담을 인터널 테이블

  CASE io_command.
    WHEN 'D'.
      "저장 버튼 비활성화 시키지
      APPEND 'SAVE' TO fcode.
      SET PF-STATUS 'S0200' EXCLUDING fcode.
      SET TITLEBAR 'T0200' WITH TEXT-dis.
    WHEN 'U'.
      APPEND 'CHANGE' TO fcode.
      SET PF-STATUS 'S0200'.
      SET TITLEBAR 'T0200' WITH TEXT-upd.
  ENDCASE.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  STATUS_0300  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE status_0300 OUTPUT.
  SET PF-STATUS 'S0300'.
*  SET TITLEBAR 'xxx'.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  CLEAR_OK_CODE  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE clear_ok_code OUTPUT.

  CLEAR: ok_code.

ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  SET_ICON  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE set_icon OUTPUT.

  "국제선인 경우 : ICON_CHECKED
  "국제선이 아닐 경우 : ICON_INCOMPLETE
  "롱 디스턴트 : "
  IF sdyn_conn-countryfr <> sdyn_conn-countryto. "출발국가와 도착국가가 같지 않다면(국제선)

    CALL FUNCTION 'ICON_CREATE'
      EXPORTING
        name                        = 'ICON_CHECKED'
     IMPORTING
       RESULT                      = gv_int
     EXCEPTIONS
       ICON_NOT_FOUND              = 1
       OUTPUTFIELD_TOO_SHORT       = 2
       OTHERS                      = 3.

  ELSE.

    CALL FUNCTION 'ICON_CREATE'
      EXPORTING
        name                        = 'ICON_INCOMPLETE'
     IMPORTING
       RESULT                      = gv_int
     EXCEPTIONS
       ICON_NOT_FOUND              = 1
       OUTPUTFIELD_TOO_SHORT       = 2
       OTHERS                      = 3.
  ENDIF.

*    "롱 디스턴스인 경우
*    IF sdyn_conn-distance > 1000.
*
*    CALL FUNCTION 'ICON_CREATE'
*      EXPORTING
*        name                        = 'ICON_CHECKED'
*     IMPORTING
*       RESULT                      = gv_long
*     EXCEPTIONS
*       ICON_NOT_FOUND              = 1
*       OUTPUTFIELD_TOO_SHORT       = 2
*       OTHERS                      = 3.
*
*  ELSE.
*
*    CALL FUNCTION 'ICON_CREATE'
*      EXPORTING
*        name                        = 'ICON_INCOMPLETE'
*     IMPORTING
*       RESULT                      = gv_long
*     EXCEPTIONS
*       ICON_NOT_FOUND              = 1
*       OUTPUTFIELD_TOO_SHORT       = 2
*       OTHERS                      = 3.
*  ENDIF.

ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  SET_DISTANCE  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE set_distance OUTPUT.

  CLEAR gs_distance.

  IF sdyn_conn-distance <= 1000.
    gs_distance-short = 'X'.
  ELSEIF sdyn_conn-distance <= 3000.
    gs_distance-medium = 'X'.
  ELSE.
    gs_distance-long = 'X'.
  ENDIF.

ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  SET_SUBSCR  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE set_subscr OUTPUT.

  CASE sdyn_conn-countryfr. "출발 국가와
    WHEN sdyn_conn-countryto. "도착 국가가 같다면(국내선)
      gv_dynnr = '0220'. "220번 서브스크린(출발, 도착 공항 정보)
    WHEN OTHERS.
      gv_dynnr = '0210'. "210번 서브스크린(출발, 도착 시간 정보)
  ENDCASE.

ENDMODULE.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
