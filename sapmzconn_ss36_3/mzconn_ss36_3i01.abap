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
      "�� �߿� ���� ���õǾ���?
      CASE 'X'. "������ �Ѵ� = 'X' �ƴϴ� = ' '(SPACE)
        WHEN gs_mode-display.
          io_command = 'D'.
          "������ �а�
          PERFORM get_data.
          LEAVE TO SCREEN 200.
        WHEN gs_mode-change.
          "ȭ�鿡 �Է��� �װ��� �ڵ�� �װ����� Lock�� ����
          PERFORM lock USING spfli-carrid spfli-connid
                       CHANGING gv_answer. "Lock�� ��Ҵ��� �� ��Ҵ��� �޾ƾ� ��

          CASE gv_answer.
            WHEN 2. "Lock �� ����(gv_answer -> 1:YES, 2:NO)
               MESSAGE i012(ZMESSAGE_SS36).
            WHEN 3.
               MESSAGE i013(ZMESSAGE_SS36).
            WHEN OTHERS.
               io_command = 'U'.
               "������ �а�(Lock�� �� ��Ҵٸ�)
               PERFORM get_data.
               LEAVE TO SCREEN 200.
          ENDCASE.

      ENDCASE.
    WHEN 'MODA'. "ȭ�� �̵��� �ƴ� �˾����� �� ȭ�� ����.
      io_command = 'D'.
      CALL SCREEN 300 STARTING AT 3 3.
*    WHEN OTHERS.
*      "��ȿ���� ���� command �Դϴ�. �޽��� ó��
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
          "Lock ó�� ����
          PERFORM lock USING spfli-carrid
                             spfli-connid
                       CHANGING gv_answer.

          CASE gv_answer.
          WHEN 2. "Lock �� ����(gv_answer -> 1:YES, 2:NO)
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
      "����ڿ��� �˾� ����(���� ��� �� ����)
      CASE io_command.
        WHEN 'U'.
          PERFORM popup_to_confirm CHANGING gv_answer.
          CASE gv_answer.
            WHEN '1'. "YES Ŭ��
              PERFORM unlocking USING spfli-carrid
                                      spfli-connid.
              "�����ϴ� ���� ����
              LEAVE TO SCREEN 100.
            WHEN '2'. "NO Ŭ��
              "���� ��ġ�� �ӹ��� �ֱ�
          ENDCASE.
        WHEN 'D'. "��ȸ ��� �� ���� �� �����ڴ�
          LEAVE TO SCREEN 100.
      ENDCASE.

    WHEN 'SAVE'.
      "1) �ؾ� �� ���� Log Table�� ���
      CALL FUNCTION 'ZUPDATE_CONN_SS36' IN UPDATE TASK
        EXPORTING
          i_sdyn_conn       = sdyn_conn.

      "2) Update Wrok Process�� ���� ����
*      COMMIT WORK. "�� �� �� �ض�

      "���� ������� ���
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
  "�˾�â �ݾƶ�
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

* ȭ�鿡�� �Է��� �װ���, �װ����� ��ȿ���� üũ
* COUNT �Լ����� INTO�� OPTIONAL)
  SELECT COUNT( * )
    FROM spfli
    WHERE carrid = spfli-carrid
    AND connid = spfli-connid.

  IF sy-subrc <> 0.
    "�޽����� �Ѹ���
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
      "���α׷��� ���� �ϰڴ�
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
