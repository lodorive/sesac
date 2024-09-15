*&---------------------------------------------------------------------*
*&  Include           MZBC410_SOLUTION_SS36I01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  CHECK_SFLIGHT  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE check_sflight INPUT.

  SELECT SINGLE *
    FROM sflight
    INTO wa_sflight

    WHERE carrid = sdyn_conn-carrid
    AND connid = sdyn_conn-connid
    AND fldate = sdyn_conn-fldate.

  CHECK sy-subrc <> 0.
  CLEAR wa_sflight.
  MESSAGE e007(bc410).

ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0100 INPUT.

  CASE ok_code.
*    LEAVE PROGRAM. "����
    WHEN 'FC1' OR 'FC2' OR 'FC3'.
      my_tabstrip-activetab = ok_code.
    WHEN 'BACK'.
      LEAVE TO SCREEN 0. "���� ȭ������
    WHEN 'TIME'.
      CALL SCREEN 150
      STARTING AT 10 10
      ENDING AT 50 20.
    WHEN 'SAVE'.
      UPDATE sflight
      FROM wa_sflight.
      IF sy-subrc <> 0.
        MESSAGE a008(bc410).
      ENDIF.
      MESSAGE s009(bc410).

  ENDCASE.

ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0150  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0150 INPUT.
  LEAVE TO SCREEN 0.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  EXIT  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE exit INPUT.

  CASE ok_code.
    WHEN 'CANCEL'.
      CLEAR: wa_sflight.
      SET PARAMETER ID:
     'CAR' FIELD wa_sflight-carrid,
     'CON' FIELD wa_sflight-connid,
     'DAY' FIELD wa_sflight-fldate.
      LEAVE TO SCREEN 100.
    WHEN 'EXIT'.
      LEAVE PROGRAM.
  ENDCASE.

ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  CHECK_PLANETYPE  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE check_planetype INPUT.

  IF sdyn_conn-planetype IS INITIAL.
    MESSAGE e555(bc410) WITH TEXT-plt.
  ENDIF.

  SELECT SINGLE seatsmax
    FROM saplane
    INTO sdyn_conn-seatsmax
    WHERE planetype = sdyn_conn-planetype.

  "�̹� �Ǹŵ� �¼� ���� ��ü �¼� ������ ���ٸ�
  IF sdyn_conn-seatsocc > sdyn_conn-seatsmax.
    MESSAGE e109(bc410).
  ELSE.
    MOVE-CORRESPONDING sdyn_conn TO wa_sflight.
  ENDIF.

ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  TRANS_FROM_TC  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE trans_from_tc INPUT.

  "ȭ�鿡 ���õ� mark�� work area�� ����(mark : X or ' ')
  MOVE sdyn_book-mark TO wa_sdyn_book-mark.

  "it_sdyn_book�� ������Ʈ �ϰڴ�.
  MODIFY it_sdyn_book INDEX my_table_control-current_line "ȭ���� ���� ������ ����
  "TRANSPORTING Ư�� �ʵ常 ������Ʈ�ϰڴٴ� ��
  FROM wa_sdyn_book TRANSPORTING mark.

ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0130  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0130 INPUT.

  CASE ok_code.
    WHEN 'SELE'. "��ü ����

      LOOP AT it_sdyn_book INTO wa_sdyn_book
                           WHERE mark = space.

      wa_sdyn_book-mark = 'X'.
      MODIFY it_sdyn_book FROM wa_sdyn_book.

      ENDLOOP.

    WHEN 'DESE'. "��ü ����

      LOOP AT it_sdyn_book INTO wa_sdyn_book
                           WHERE mark = 'X'.

      wa_sdyn_book-mark = space.
      MODIFY it_sdyn_book FROM wa_sdyn_book.

      ENDLOOP.

    WHEN 'SRTU'. "��������
      READ TABLE my_table_control-cols
           WITH KEY selected = 'X' INTO wa_cols.

      SORT it_sdyn_book
      BY (wa_cols-screen-name+10)
      ASCENDING.

    WHEN 'SRTD'. "��������
      READ TABLE my_table_control-cols
           WITH KEY selected = 'X' INTO wa_cols.

      SORT it_sdyn_book
      BY (wa_cols-screen-name+10)
      DESCENDING.

  ENDCASE.

ENDMODULE.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
