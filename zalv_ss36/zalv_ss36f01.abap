*&---------------------------------------------------------------------*
*&  Include           ZREPORT_SS36F01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Form  GET_DATE
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM get_data .

* 화면에서 입력한 조건의 예약 정보 취득
  CASE pa_can. "취소 포함이
    WHEN 'X'. "선택되어 있다면
      SELECT *
        FROM sbook
        LEFT OUTER JOIN scustom
        ON sbook~customid = scustom~id
        INTO CORRESPONDING FIELDS OF TABLE gt_book
        WHERE carrid = pa_car
        AND connid = pa_con
        AND fldate IN so_fld.

    WHEN OTHERS. "취소 정보 불포함
      SELECT *
        FROM sbook
        LEFT OUTER JOIN scustom
        ON sbook~customid = scustom~id
        INTO CORRESPONDING FIELDS OF TABLE gt_book
        WHERE carrid = pa_car
        AND connid = pa_con
        AND fldate IN so_fld
        AND cancelled <> 'X'.
  ENDCASE.

  "무게에 따른 신호등 처리( > 15kg 빨간색)
  LOOP AT gt_book INTO gw_book." WHERE luggweight > c_max_weight.
    IF gw_book-luggweight > c_max_weight.
      gw_book-light = 1. "빨간색 신호등.
    ENDIF.

    IF gw_book-cancelled = 'X'.
      gw_book-lcolor = 'C600'. "흐린 빨간색 라인(C는 고정, 컬러, 강조 할지말지, inverse 할지 말지
      gw_book-cancelled_icon = icon_okay.
    ENDIF.

    MODIFY gt_book FROM gw_book
    TRANSPORTING light lcolor cancelled_icon.
  ENDLOOP.



ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  SET_ALV
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM set_alv .

  "화면 갱신 시 스크롤바 고정 정보
  gs_stable-row = 'X'. " 가로 스크롤바 고정
  gs_stable-col = 'X'. " 세로 스크롤바 고정

  "Layout Variant 설정 로직
  gs_variant-report = sy-cprog. " 현재 프로그램에 있는
  gs_variant-variant = p_vari. " 화면에서 입력 받은 View 유형

  gv_save = 'A'. "A or U or X
  " U(User Specific) -> 내가 만든 Variant는 다른 사용자가 볼 수 없다
  " X(Cross User) -> 다른 사용자가 볼 수 있음
  " A(All) -> (U or X)

  "ALV 화면 제어
  gs_layout-grid_title = TEXT-t01.
  gs_layout-zebra = 'X'. "화면이 흐리고.. 안 흐리고..
*  gs_layout-no_headers = 'X'. "헤더 삭제
  gs_layout-totals_bef = 'X'. "합계를 첫 번째 줄로 이동
  gs_layout-sel_mode = 'A'. "라인 선택하고 싶을 때(space/A/B/C/D)
  gs_layout-excp_fname = 'LIGHT'. "신호등 컬럼 알려주기
  gs_layout-excp_led = 'X'. "1구 신호등으로 변경하기
  gs_layout-info_fname  = 'LCOLOR'. "라인 컬러.

  "정렬 정보 구성(fldate DESC / customid ASC)
  CLEAR gw_sort.
  gw_sort-fieldname = 'FLDATE'. "정리할 컬럼이 뭐니?
  gw_sort-down        = 'X'.
  APPEND gw_sort TO gt_sort.

  CLEAR gw_sort.
  gw_sort-fieldname = 'CUSTOMID'.
  gw_sort-up        = 'X'.
  APPEND gw_sort TO gt_sort.

  "프린트 버튼 숨기기..(MC_FC_PRINT)
*  APPEND cl_gui_alv_grid=>mc_fc_print
*      TO gt_hide.

  "예외 컬럼 등록하기
*  CLEAR gw_fcat.
*  gw_fcat-fieldname = 'NAME'. "인터널 테이블에 추가된 예외 컬럼 이름
*  gw_fcat-ref_field = 'NAME'.  "어느 필드를 참조하니?
*  gw_fcat-ref_table = 'SCUSTOM'. "어느 테이블이니?
*  gw_fcat-col_pos = 7. "삽입할 컬럼 위치
*  APPEND gw_fcat TO gt_fcat.
*
*  CLEAR gw_fcat.
*  gw_fcat-fieldname = 'TELEPHONE'. "인터널 테이블에 추가된 예외 컬럼 이름
*  gw_fcat-ref_field = 'TELEPHONE'.  "어느 필드를 참조하니?
*  gw_fcat-ref_table = 'SCUSTOM'. "어느 테이블이니?
*  gw_fcat-col_pos = 8. "삽입할 컬럼 위치
*  APPEND gw_fcat TO gt_fcat.

*  CLEAR gw_fcat.
*  gw_fcat-fieldname = 'CANCELLED'. "인터널 테이블에 추가된 예외 컬럼 이름
*  gw_fcat-no_out = 'X'. "이 필드를 숨겨줘
*  APPEND gw_fcat TO gt_fcat.
*
*  CLEAR gw_fcat.
*  gw_fcat-fieldname = 'CANCELLED_ICON'. "인터널 테이블에 추가된 예외 컬럼 이름
*  gw_fcat-icon = 'X'. "아이콘으로 표시할게
*  gw_fcat-coltext = 'Canelled'(h05).
*  gw_fcat-col_pos = 9. "삽입할 컬럼 위치
**  gw_fcat-outputlen = 5.
*  APPEND gw_fcat TO gt_fcat.

ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  F4_VARIANT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM f4_variant .

  DATA ls_variant TYPE disvariant.
  DATA es_variant TYPE disvariant.

  ls_variant-report = sy-cprog.

  CALL FUNCTION 'REUSE_ALV_VARIANT_F4'
    EXPORTING
      is_variant    = ls_variant
*     I_TABNAME_HEADER          =
*     I_TABNAME_ITEM            =
*     IT_DEFAULT_FIELDCAT       =
*     I_SAVE        = ' '
*     I_DISPLAY_VIA_GRID        = ' '
    IMPORTING
*     E_EXIT        =
      es_variant    = es_variant
    EXCEPTIONS
      not_found     = 1
      program_error = 2
      OTHERS        = 3.

  p_vari = es_variant-variant.

ENDFORM.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
