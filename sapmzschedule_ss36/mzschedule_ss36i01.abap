*&---------------------------------------------------------------------*
*&  Include           MZSCHEDULE_SS36I01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0100 INPUT.

  CASE ok_code.
    WHEN 'CTASCE'.
      "각자 구현 해보기
      "현재 마우스 커서 있는 위치에 필드 이름을 얻어와라
      GET CURSOR FIELD gv_fieldname.
*      GET CURSOR LINE selline. "현재 라인의 위치
*      tabix = my_table-top_line + selline - 1.
*      READ TABLE my_table-cols INTO gw_col
*      INDEX tabix.
        SORT gt_flight
*        BY (gw_col-screen-name+15) ASCENDING.
        BY (gv_fieldname+15) ASCENDING.

    WHEN 'CTDESC'.

      GET CURSOR LINE selline. "현재 라인의 위치
      tabix = my_table-top_line + selline - 1.
      READ TABLE my_table-cols INTO gw_col
      INDEX tabix.

        SORT gt_flight
        BY (gw_col-screen-name+15) DESCENDING.

    WHEN 'ASCE'.
      "1) 어떤 컬럼을 선택했는지
      READ TABLE my_table-cols
           WITH KEY selected = 'X' INTO gw_col.

      IF sy-subrc <> 0.
        MESSAGE i010(zmessage_ss36).
      ELSE.

        "2) table-control과 연결된 변수 정렬
*      MESSAGE gw_col-screen-name+15 TYPE 'I'.
        SORT gt_flight
        BY (gw_col-screen-name+15) ASCENDING.
      ENDIF.

    WHEN 'DESC'.

      READ TABLE my_table-cols
      WITH KEY selected = 'X' INTO gw_col.

      IF sy-subrc <> 0.
        MESSAGE i010(zmessage_ss36).
      ELSE.

        "2) table-control과 연결된 변수 정렬
*      MESSAGE gw_col-screen-name+15 TYPE 'I'.
        SORT gt_flight
        BY (gw_col-screen-name+15) DESCENDING.
      ENDIF.

    WHEN 'SEAR'.
      "화면에서 입력한 검색 조건을 이용하여,
      "테이블 컨트롤과 연결할 인터널 테이블에
      "값 채우기
      SELECT *
        FROM sflight
        INTO CORRESPONDING FIELDS OF TABLE gt_flight
        WHERE carrid = spfli-carrid
        AND connid = spfli-connid.

      SORT gt_flight BY fldate DESCENDING. "최근 비행일자를 맨 위로

      "테이블 컨트롤에게 전체 건 수가 몇 건인지 알려줘야 함
      "니가 지금 컨트롤 해야 할 행 수를 알려주는 거임
      my_table-lines = lines( gt_flight ). "항상 들어가야 함

  ENDCASE.

ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  TRANSFER_SCREEN_TO_DATA  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE transfer_screen_to_data INPUT.

  "화면을 인터널 테이블로
  MOVE-CORRESPONDING zssflight_ss36 TO gw_flight.

  "화면의 현재 라인의 값을 Internal Table에 업데이트
  MODIFY gt_flight FROM gw_flight
  INDEX my_table-current_line.

ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  CHANGE_TC  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE change_tc INPUT.

  "나의 테이블컨트롤의 고정 컬럼을 화면에서 입력한 값으로
  my_table-fixed_cols = gv_fixed.

  "고정 컬럼에 대해서는 진한색으로 설정
  " my_table-cols = 테이블컨트롤의 컬럼(전체)에 대한 속성을 가지고 있음
  LOOP AT my_table-cols INTO gw_col.
    "컬럼의 순서가 고정 컬럼보다 작거나 같다면
    IF gw_col-index <= my_table-fixed_cols.
      "진한색으로 설정
      gw_col-screen-intensified = 1.
    ELSE.
      gw_col-screen-intensified = 0.
    ENDIF.
    MODIFY my_table-cols FROM gw_col.
  ENDLOOP.

ENDMODULE.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
