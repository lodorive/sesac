*&---------------------------------------------------------------------*
*&  Include           MZCONN_SS36I01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  GET_DATA  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*MODULE get_data INPUT.
*
*  SELECT SINGLE *
*    FROM spfli
*    INTO CORRESPONDING FIELDS OF sdyn_conn
*    WHERE carrid = spfli-carrid
*    AND connid = spfli-connid.
*
*ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0100 INPUT.

*  MESSAGE 'Radiobutton Clicked' TYPE 'I'.

  CASE ok_code.
    WHEN 'MOVE'.
      "둘 중에 누가 선택되었니?
      CASE 'X'. "선택을 한다 = 'X' 아니다 = ' '(SPACE)
        WHEN gs_mode-display.
          io_command = 'D'.
          "데이터 읽고
          PERFORM get_data.
          LEAVE TO SCREEN 200.
        WHEN gs_mode-change.
          "화면에 입력한 항공사 코드와 항공편의 Lock을 잡음
          PERFORM lock USING spfli-carrid spfli-connid
                       CHANGING gv_answer. "Lock을 잡았는지 안 잡았는지 받아야 함

          CASE gv_answer.
            WHEN 2. "Lock 못 잡음(gv_answer -> 1:YES, 2:NO)
               MESSAGE i012(ZMESSAGE_SS36).
            WHEN 3.
               MESSAGE i013(ZMESSAGE_SS36).
            WHEN OTHERS.
               io_command = 'U'.
               "데이터 읽고(Lock을 잘 잡았다면)
               PERFORM get_data.
               LEAVE TO SCREEN 200.
          ENDCASE.

      ENDCASE.
    WHEN 'MODA'. "화면 이동이 아닌 팝업으로 상세 화면 제공.
      io_command = 'D'.
      CALL SCREEN 300 STARTING AT 3 3.
*    WHEN OTHERS.
*      "유효하지 않은 command 입니다. 메시지 처리
*      MESSAGE i007(zmessage_ss36) WITH io_command.
  ENDCASE.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0200  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0200 INPUT.

  CASE ok_code.
*    WHEN 'TAB1'.
*      my_tabstrip-activetab = 'TAB1'.
*    WHEN 'TAB2'.
*      my_tabstrip-activetab = 'TAB2'.
*    WHEN 'TAB3'.
*      my_tabstrip-activetab = 'TAB3'.
*    WHEN 'TAB4'.
*      my_tabstrip-activetab = 'TAB4'.
    WHEN 'TAB1' OR 'TAB2' OR 'TAB3' OR 'TAB4'.
      my_tabstrip-activetab = ok_code.
    WHEN 'TOGG'.
      CASE io_command.
        WHEN 'U'.
          PERFORM unlocking USING spfli-carrid
                                  spfli-connid.
          io_command = 'D'.

        WHEN 'D'.
          "Lock 처리 수행
          PERFORM lock USING spfli-carrid
                             spfli-connid
                       CHANGING gv_answer.

          CASE gv_answer.
          WHEN 2. "Lock 못 잡음(gv_answer -> 1:YES, 2:NO)
             MESSAGE i012(ZMESSAGE_SS36).
          WHEN 3.
             MESSAGE i013(ZMESSAGE_SS36).
          WHEN OTHERS.
             io_command = 'U'.
             LEAVE TO SCREEN 200.
        ENDCASE.

          io_command = 'U'.
      ENDCASE.
    WHEN 'BACK'.
      "사용자에게 팝업 띄우기(수정 모드 일 때만)
      CASE io_command.
        WHEN 'U'.
          PERFORM popup_to_confirm CHANGING gv_answer.
          CASE gv_answer.
            WHEN '1'. "YES 클릭
              PERFORM unlocking USING spfli-carrid
                                      spfli-connid.
              "저장하는 로직 구현
              LEAVE TO SCREEN 100.
            WHEN '2'. "NO 클릭
              "현재 위치에 머물러 있기
          ENDCASE.
        WHEN 'D'. "조회 모드 일 때는 걍 나가겠다
          LEAVE TO SCREEN 100.
      ENDCASE.

    WHEN 'SAVE'.
      "1) 해야 할 일을 Log Table에 기록
      CALL FUNCTION 'ZUPDATE_CONN_SS36' IN UPDATE TASK
        EXPORTING
          i_sdyn_conn       = sdyn_conn.

      "2) Update Wrok Process에 일을 위임
*      COMMIT WORK. "너 일 좀 해라

      "동기 방식으로 사용
      COMMIT WORK AND WAIT.

      IF sy-subrc = 0.
        MESSAGE s014(zmessage_ss36).
        LEAVE TO SCREEN 100.
      ENDIF.

*      MESSAGE s014(zmessage_ss36).
*      LEAVE TO SCREEN 100.
  ENDCASE.

ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0300  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0300 INPUT.
  "팝업창 닫아라
  CASE ok_code.
    WHEN 'OKAY'.
      LEAVE TO SCREEN 0.
  ENDCASE.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  CHECK-CONNID  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE check-connid INPUT.

* 화면에서 입력한 항공사, 항공편이 유효한지 체크
* COUNT 함수에서 INTO는 OPTIONAL)
  SELECT COUNT( * )
    FROM spfli
    WHERE carrid = spfli-carrid
    AND connid = spfli-connid.

  IF sy-subrc <> 0.
    "메시지를 뿌린다
    MESSAGE e008(zmessage_ss36) WITH spfli-carrid.
  ENDIF.

ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  EXIT  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE exit INPUT.

  CASE ok_code.
    WHEN 'EXIT'.
      "프로그램을 종료 하겠다
      LEAVE TO SCREEN 0. "LEAVE PROGRAM.
    WHEN 'BACK'.
      LEAVE PROGRAM.
  ENDCASE.

ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  CHECK-CONN  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE check_conn_fr INPUT.

  SELECT COUNT( * )
    FROM sgeocity
    WHERE country = sdyn_conn-countryfr
     AND city = sdyn_conn-cityfrom.

  IF sy-subrc <> 0.
    MESSAGE e009(zmessage_ss36)
    WITH sdyn_conn-countryfr
         sdyn_conn-cityfrom.
  ENDIF.

ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  CHECK_CONN_TO  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE check_conn_to INPUT.

  SELECT COUNT( * )
    FROM sgeocity
    WHERE country = sdyn_conn-countryto
     AND city = sdyn_conn-cityto.

  IF sy-subrc <> 0.
    MESSAGE e009(zmessage_ss36)
    WITH sdyn_conn-countryto
         sdyn_conn-cityto.
  ENDIF.

ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  F4HELP_CONNID  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE f4help_connid INPUT.

ENDMODULE.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
