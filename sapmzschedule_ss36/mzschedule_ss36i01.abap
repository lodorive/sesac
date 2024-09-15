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
      "���� ���� �غ���
      "���� ���콺 Ŀ�� �ִ� ��ġ�� �ʵ� �̸��� ���Ͷ�
      GET CURSOR FIELD gv_fieldname.
*      GET CURSOR LINE selline. "���� ������ ��ġ
*      tabix = my_table-top_line + selline - 1.
*      READ TABLE my_table-cols INTO gw_col
*      INDEX tabix.
        SORT gt_flight
*        BY (gw_col-screen-name+15) ASCENDING.
        BY (gv_fieldname+15) ASCENDING.

    WHEN 'CTDESC'.

      GET CURSOR LINE selline. "���� ������ ��ġ
      tabix = my_table-top_line + selline - 1.
      READ TABLE my_table-cols INTO gw_col
      INDEX tabix.

        SORT gt_flight
        BY (gw_col-screen-name+15) DESCENDING.

    WHEN 'ASCE'.
      "1) � �÷��� �����ߴ���
      READ TABLE my_table-cols
           WITH KEY selected = 'X' INTO gw_col.

      IF sy-subrc <> 0.
        MESSAGE i010(zmessage_ss36).
      ELSE.

        "2) table-control�� ����� ���� ����
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

        "2) table-control�� ����� ���� ����
*      MESSAGE gw_col-screen-name+15 TYPE 'I'.
        SORT gt_flight
        BY (gw_col-screen-name+15) DESCENDING.
      ENDIF.

    WHEN 'SEAR'.
      "ȭ�鿡�� �Է��� �˻� ������ �̿��Ͽ�,
      "���̺� ��Ʈ�Ѱ� ������ ���ͳ� ���̺�
      "�� ä���
      SELECT *
        FROM sflight
        INTO CORRESPONDING FIELDS OF TABLE gt_flight
        WHERE carrid = spfli-carrid
        AND connid = spfli-connid.

      SORT gt_flight BY fldate DESCENDING. "�ֱ� �������ڸ� �� ����

      "���̺� ��Ʈ�ѿ��� ��ü �� ���� �� ������ �˷���� ��
      "�ϰ� ���� ��Ʈ�� �ؾ� �� �� ���� �˷��ִ� ����
      my_table-lines = lines( gt_flight ). "�׻� ���� ��

  ENDCASE.

ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  TRANSFER_SCREEN_TO_DATA  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE transfer_screen_to_data INPUT.

  "ȭ���� ���ͳ� ���̺��
  MOVE-CORRESPONDING zssflight_ss36 TO gw_flight.

  "ȭ���� ���� ������ ���� Internal Table�� ������Ʈ
  MODIFY gt_flight FROM gw_flight
  INDEX my_table-current_line.

ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  CHANGE_TC  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE change_tc INPUT.

  "���� ���̺���Ʈ���� ���� �÷��� ȭ�鿡�� �Է��� ������
  my_table-fixed_cols = gv_fixed.

  "���� �÷��� ���ؼ��� ���ѻ����� ����
  " my_table-cols = ���̺���Ʈ���� �÷�(��ü)�� ���� �Ӽ��� ������ ����
  LOOP AT my_table-cols INTO gw_col.
    "�÷��� ������ ���� �÷����� �۰ų� ���ٸ�
    IF gw_col-index <= my_table-fixed_cols.
      "���ѻ����� ����
      gw_col-screen-intensified = 1.
    ELSE.
      gw_col-screen-intensified = 0.
    ENDIF.
    MODIFY my_table-cols FROM gw_col.
  ENDLOOP.

ENDMODULE.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
