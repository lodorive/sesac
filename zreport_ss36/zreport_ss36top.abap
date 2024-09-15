*&---------------------------------------------------------------------*
*& Include ZREPORT_SS36TOP                                   Report ZREPORT_SS36
*&
*&---------------------------------------------------------------------*
REPORT zreport_ss36.

TABLES spfli.

TABLES sscrfields. "화면에서 어떤 버튼이 클릭됐는지를 구별하기 위한 변수

* 첫 번째 탭을 위한 화면
SELECTION-SCREEN BEGIN OF SCREEN 110 AS SUBSCREEN. "AS SUBSCREEN 응 이거 서브스크린임
  PARAMETERS pa_car TYPE scarr-carrid MEMORY ID car. " 항공사 입력
  SELECT-OPTIONS so_con FOR spfli-connid NO-EXTENSION. " 항공편
SELECTION-SCREEN END OF SCREEN 110.

* 두 번째 탭을 위한 화면
SELECTION-SCREEN BEGIN OF SCREEN 120 AS SUBSCREEN.
  PARAMETERS pa_bid TYPE sbook-bookid.
SELECTION-SCREEN END OF SCREEN 120.

* 탭 스트립 그리기
SELECTION-SCREEN BEGIN OF TABBED BLOCK blk1 FOR 3 LINES.
                  "탭 길이    "레이블             "ok_code
  SELECTION-SCREEN TAB (10) tab1 USER-COMMAND comm1 DEFAULT SCREEN 110.
  SELECTION-SCREEN TAB (10) tab2 USER-COMMAND comm2 DEFAULT SCREEN 120.
SELECTION-SCREEN END OF BLOCK blk1.

SELECTION-SCREEN SKIP 1. " 한칸 띄우겠다

SELECTION-SCREEN BEGIN OF BLOCK out
  WITH FRAME "with FRAME 박스에다 선을 긋겠다
  TITLE TEXT-t01. "box에다 제목을 달겠다

* USER-COMMAND 얘를 받아야만 사용자가 체크박스를 선택했을 때 PAI 발생
PARAMETERS pa_name AS CHECKBOX. "USER-COMMAND name, " 체크 박스
PARAMETERS pa_curr AS CHECKBOX USER-COMMAND curr.

SELECTION-SCREEN SKIP 1. " 한칸 띄우겠다
* MODIF ID -> GROUPING(한 번에 처라하기 위해)
PARAMETERS: pa_lim_1 RADIOBUTTON GROUP lim MODIF ID xyz, " 라디오 버튼
            pa_lim_2 RADIOBUTTON GROUP lim MODIF ID xyz DEFAULT 'X', " 화면이 뜨자마자 선택
            pa_lim_3 RADIOBUTTON GROUP lim MODIF ID xyz.

SELECTION-SCREEN END OF BLOCK out.

SELECTION-SCREEN SKIP 1. " 한칸 띄우겠다

* 한 줄에 뿌리겠다
* COMMENT : 레이블 그리는거 (스크린 프로그램에서 T 아이콘 눌러서 그리는 것과 같음)
SELECTION-SCREEN BEGIN OF LINE.

SELECTION-SCREEN COMMENT 1(20) TEXT-c01.

"pos_low(예약어) 이 위치(selection option)에다가 8칸 확보
"FOR FIELD <pa_priv> 이 레이블은 이 필드를 위한 레이블이야
SELECTION-SCREEN COMMENT pos_low(8) TEXT-c02 FOR FIELD pa_priv.
PARAMETERS pa_priv AS CHECKBOX.

"pos_low(예약어) 이 위치(selection option)에다가 8칸 확보
"FOR FIELD <pa_busi> 이 레이블은 이 필드를 위한 레이블이야
SELECTION-SCREEN COMMENT pos_high(8) TEXT-c03 FOR FIELD pa_busi.
PARAMETERS pa_busi AS CHECKBOX.

SELECTION-SCREEN END OF LINE.

                                       "버튼 텍스트
SELECTION-SCREEN PUSHBUTTON /pos_low(8) gv_btn1
USER-COMMAND on1.
SELECTION-SCREEN PUSHBUTTON pos_high(8) gv_btn2
USER-COMMAND on2.

* 1100번 화면 (사용자가 이름 선택 시 부가적인 선택 팝업(성 + 이름)
SELECTION-SCREEN BEGIN OF SCREEN 1100.
  PARAMETERS pa_first AS CHECKBOX.
  PARAMETERS pa_last AS CHECKBOX.
SELECTION-SCREEN END OF SCREEN 1100.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
