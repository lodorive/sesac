*&---------------------------------------------------------------------*
*&  Include           MZCONN_SS36I01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  GET_DATA  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE get_data INPUT.

  SELECT SINGLE *
    FROM spfli
    INTO CORRESPONDING FIELDS OF sdyn_conn
    WHERE carrid = spfli-carrid
    AND connid = spfli-connid.

ENDMODULE.
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
        WHEN gs_mode-change.
          io_command = 'U'.
      ENDCASE.
      LEAVE TO SCREEN 200.
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
    WHEN 'TOGG'.
      CASE io_command.
        WHEN 'U'.
          io_command = 'D'.
        WHEN 'D'.
          io_command = 'U'.
      ENDCASE.
    WHEN 'BACK'.
      "����ڿ��� �˾� ����(���� ��� �� ����)
      CASE io_command.
        WHEN 'U'.
          PERFORM popup_to_confirm CHANGING gv_answer.
          CASE gv_answer.
            WHEN '1'. "YES Ŭ��
              "�����ϴ� ���� ����
              LEAVE TO SCREEN 100.
            WHEN '2'. "NO Ŭ��
              "���� ��ġ�� �ӹ��� �ֱ�
          ENDCASE.
        WHEN 'D'. "��ȸ ��� �� ���� �� �����ڴ�
          LEAVE TO SCREEN 100.
      ENDCASE.

    WHEN 'SAVE'.
      MESSAGE 'To be continue...' TYPE 'I'.

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

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
