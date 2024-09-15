*&---------------------------------------------------------------------*
*& Include MZCONN_SS36TOP                                    Module Pool      SAPMZCONN_SS36
*&
*&---------------------------------------------------------------------*
PROGRAM sapmzconn_ss36.

* 100번 화면과 200번 화면을 위한 변수
TABLES: spfli, sdyn_conn.

DATA io_command.
DATA ok_code TYPE sy-ucomm. "어떤 버튼이 클릭 됐는지를 구별하기 위한 변수

* 국제선 여부 / 롱 디스턴트를 위한 아이콘
DATA gv_int TYPE icons-text.
DATA gv_long TYPE icons-text.

DATA: BEGIN OF gs_mode,
        display,"TYPE c LENGTH 1.
        change  VALUE 'X', "프로그램이 뜨자마자 CHANGE가 Default 값
      END OF gs_mode.

DATA: BEGIN OF gs_distance,
        short,
        medium,
        long,
      END OF gs_distance.

DATA gv_answer.

DATA gv_dynnr TYPE sy-dynnr. "210 or 220

* 탭스트립 컨트롤과 통신할 변수
CONTROLS: my_tabstrip TYPE TABSTRIP.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
