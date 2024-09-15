*&---------------------------------------------------------------------*
*& Include ZREPORT_SS36TOP                                   Report ZREPORT_SS36
*&
*&---------------------------------------------------------------------*
REPORT zalv_ss36top.

* 검색 조건에서 항공사 코드, 항공편, 날짜(범위)를 입력 받아
* 해당 결과를 ALV로 조회하는 프로그램 구현

*DATA gt_book TYPE TABLE OF sbook. " <- ALV에 출력할 인터널 테이블
*DATA gw_book LIKE LINE OF gt_book.

CONSTANTS c_max_weight TYPE sbook-luggweight VALUE '25'.

DATA: BEGIN OF gw_book.
    INCLUDE STRUCTURE zalv_ss36.
DATA light(1). "신호등을 위한 컬럼
DATA lcolor(4). "라인 컬러를 위한 컬럼

"예외 컬럼 등록(고객 이름, 고객 전화번호)
*  DATA name TYPE scustom-name.
*  DATA telephone TYPE scustom-telephone.
*  DATA cancelled_icon TYPE icons-text.
DATA: END OF gw_book.
DATA gt_book LIKE TABLE OF gw_book. "<- ALV에 출력할 인터널 테이블

DATA ok_code TYPE sy-ucomm.

* ALV를 위한 레퍼런스 변수 2개 선언
* go_xxx -> Global Object
DATA go_cont TYPE REF TO cl_gui_custom_container.
DATA go_alv TYPE REF TO cl_gui_alv_grid.

* ALV 제어를 위한 변수
DATA gs_stable TYPE lvc_s_stbl.
DATA gs_variant TYPE disvariant.
DATA gv_save TYPE char01.

DATA gs_layout TYPE lvc_s_layo.

DATA gt_sort TYPE lvc_t_sort. " 정렬 기준 정보(여러 건의 정렬 기준을 담아야 하므로 table 타입)
DATA gw_sort TYPE lvc_s_sort.

DATA gt_hide TYPE ui_functions. "숨길 버튼들 정보.

* 예외 컬럼을 제어할 필드카달로그 정의
DATA gt_fcat TYPE lvc_t_fcat.
DATA gw_fcat TYPE lvc_s_fcat.

* 이벤트 핸들러에 대한 클래스를 정의(위치 바람직)
* DEFINITION와 IMPLEMENTATION는 항상 세트
CLASS lcl_handler DEFINITION. " 클래스에 대한 정의(데이터 타입 정의)
  PUBLIC SECTION.
    "이벤트 핸들러를 정의 on_<이벤트 이름>
    CLASS-METHODS on_double_click "이 메소드가 동작할거임
      FOR EVENT double_click "더블 클릭 이벤트에 대해
                  OF cl_gui_alv_grid "해당 클래스에서
      IMPORTING es_row_no. "나는 이 파라미터가 필요해(더블클릭된 라인)

    CLASS-METHODS on_toolbar "이 메소드가 동작할거임
      FOR EVENT toolbar "툴바 이벤트에 대해
                  OF cl_gui_alv_grid "해당 클래스에서
      IMPORTING e_object. "파라미터(fcode)

    " toolbar와 user_command는 세트이다
    CLASS-METHODS on_user_command "이 메소드가 동작할거임
      FOR EVENT user_command "user_command 이벤트에 대해
                  OF cl_gui_alv_grid "해당 클래스에서
      IMPORTING e_ucomm. "파라미터(fcode)

    " 모든 페이지 상단에 사용자가 언제 몇 시 몇 분에 출력을 했는지
    " 얘는 파라미터가 존재하지 않음
    CLASS-METHODS on_print_top_of_page "이 메소드가 동작할거임
        FOR EVENT print_top_of_page "print 이벤트에 대해
        OF cl_gui_alv_grid. "해당 클래스에서

    " 현재 사용자가 누른 디테일 버튼의 기능을 바꾸기 위한 메소드
    CLASS-METHODS on_before_user_command "이 메소드가 동작할거임
      FOR EVENT before_user_command "before_user_command 이벤트에 대해
                  OF cl_gui_alv_grid "해당 클래스에서
      IMPORTING e_ucomm. " 스탠다드 버튼에 대한 펑션 코드

    CLASS-METHODS on_context_menu_request "이 메소드가 동작할거임
      FOR EVENT context_menu_request "context_menu 이벤트에 대해
                  OF cl_gui_alv_grid "해당 클래스에서
      IMPORTING e_object. " Context_menu를 삽입하기 위한 오브젝트

ENDCLASS.

CLASS lcl_handler IMPLEMENTATION. " 클래스에 대한 구현(변수 정의)

  METHOD on_double_click.
    "어떻게 동작할지 구현
*      MESSAGE 'I am clicked!' TYPE 'I'.
    "현재 클릭된 라인의 고객 ID를 취득
    READ TABLE gt_book INTO gw_book INDEX es_row_no-row_id.
    IF sy-subrc <> 0.
      "이런 일이 발생할 일은 없다
    ELSE.
      "고객 상세 화면을 띄운다
      CALL FUNCTION 'DR_DISPLAY_CUSTOMER'
        EXPORTING
          id = gw_book-customid.
    ENDIF.

*    MESSAGE i016(bc408) WITH gw_book-customid. "더블클릭된 행의 정보
  ENDMETHOD.

  METHOD on_toolbar.
    "추가할 버튼 구성하기(고객 정보 조회 버튼)
    DATA lw_button TYPE stb_button.

    CLEAR lw_button.
    lw_button-function = 'CUST'. "ALV 안에 있는 버튼(ok_code랑 관련 X)
    lw_button-icon = icon_customer.
    lw_button-text = 'Customer'.

    "화면에 추가
    INSERT lw_button INTO TABLE e_object->mt_toolbar.

  ENDMETHOD.

  METHOD on_user_command.
    DATA lt_selected TYPE lvc_t_row.
    DATA lw_selected TYPE lvc_s_row.

    CASE e_ucomm.
      WHEN 'CARR'. " 항공사의 상세 정보를 조회 한다(DR_DISPLAY_CARRID)
        " 어차피 ALV로 넘어왔다는건 항공사 값(only 1)이 들어왔단 뜻이기 때문에
        " 라인의 정보를 읽어올 필요 없음
        READ TABLE gt_book INTO gw_book INDEX 1.

        CALL FUNCTION 'DR_DISPLAY_CARRID'
          EXPORTING
            carrid        = gw_book-carrid.

      WHEN 'CUST'. "사용자가 고객 버튼을 클릭
        " 1) 현재 사용자가 ALV에서 선택된 라인의 정보를 읽음
        CALL METHOD go_alv->get_selected_rows
          IMPORTING
            et_index_rows = lt_selected.
*            et_row_no     =.

        " 2) 예외 : 여러 라인 선택 또는 라인 선택 안한 경우 -> 메시지 처리
        " lines -> 인터널 테이블에 몇 개 행이 있는지
        IF lines( lt_selected ) <> 1. " 1개의 라인 이상 선택했다면
          MESSAGE i019(ZMESSAGE_SS36).
        ELSE.

        " 현재 인터널 테이블에 담긴 행이 몇 번째 행인지
        " 위에서 예외처리 해줬기 때문에 테이블에는 하나의 데이터밖에 없음
        READ TABLE lt_selected INTO lw_selected INDEX 1.
        " 해당 행의 고객 ID 정보를 취득
        READ TABLE gt_book INTO gw_book INDEX lw_selected-index.

        " 3) 고객 상세 정보 함수 호출
        CALL FUNCTION 'DR_DISPLAY_CUSTOMER'
        EXPORTING
          id = gw_book-customid.
        ENDIF.

      ENDCASE.

    ENDMETHOD.

    METHOD on_print_top_of_page.

      WRITE:/ 'Who:', sy-uname COLOR COL_KEY.
      WRITE:/ 'When:', sy-datum, sy-uzeit.

    ENDMETHOD.

    METHOD on_before_user_command.

      "1) 사용자가 스탠다의 상세 조회 버튼을 클릭하면 항공사 상세 조회 기능으로 대체
      CASE e_ucomm.
        WHEN cl_gui_alv_grid=>mc_fc_detail. "사용자가 얘를 클릭하면
          CALL METHOD go_alv->set_user_command
            EXPORTING
              i_ucomm = 'CARR'. "기능을 얘로 대체하겠다
      ENDCASE.

    ENDMETHOD.

    METHOD on_context_menu_request.

      " ALV에서 마우스 우클릭 시 Context Menu를 띄운다
      CALL METHOD cl_ctmenu=>load_gui_status
        EXPORTING
          program    = sy-cprog
          status     = 'S0100_ALV'
*          disable    =
          menu       = e_object
        EXCEPTIONS
          read_error = 1
          others     = 2.

    ENDMETHOD.

ENDCLASS.


PARAMETERS pa_car TYPE sbook-carrid MEMORY ID car OBLIGATORY. "필수 값
PARAMETERS pa_con TYPE sbook-connid MEMORY ID con OBLIGATORY. "필수 값
SELECT-OPTIONS so_fld FOR gw_book-fldate NO-EXTENSION.

* 화면에서 예약 조회시 취소건을 포함할지 말지 check box로 제공
PARAMETERS pa_can AS CHECKBOX DEFAULT 'X'. " 취소건 포함

SELECTION-SCREEN SKIP 1.

* ALV 화면을 띄울 View 정보를 입력 받음
PARAMETERS p_vari TYPE disvariant-variant. " 보고자 하는 view가 뭔지..?

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
