*&---------------------------------------------------------------------*
*&  Include           MZCONN_SS36F01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Form  POPUP_TO_CONFIRM
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      <--P_GV_ANSWER  text
*----------------------------------------------------------------------*
FORM popup_to_confirm  CHANGING f_answer TYPE c.

  CALL FUNCTION 'POPUP_TO_CONFIRM'
    EXPORTING
     TITLEBAR                    = 'EXIT CONNECTION'
     text_question               = 'Do you want to leave?'
     TEXT_BUTTON_1               = 'Yes'(001)
     TEXT_BUTTON_2               = 'No'(002)
     DISPLAY_CANCEL_BUTTON       = ' ' "�ʿ� ����
   IMPORTING
     ANSWER                      = f_answer
   EXCEPTIONS
     TEXT_NOT_FOUND              = 1
     OTHERS                      = 2.

ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  LOCK
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      -->P_SPFLI_CARRID  text
*      -->P_SPFLI_CONNID  text
*      <--P_GV_ANSWER  text
*----------------------------------------------------------------------*
FORM lock  USING    p_carrid TYPE spfli-carrid
                    p_connid TYPE spfli-connid
           CHANGING p_answer TYPE c.

  "�� ��� �Լ� ȣ��
  CALL FUNCTION 'ENQUEUE_EZ_CONN_SS36'
   EXPORTING
*     MODE_SPFLI           = 'E' " E : ������ ���� �� Lock ����
*     MANDT                = SY-MANDT
     CARRID               = p_carrid
     CONNID               = p_connid
*     X_CARRID             = 'X' " SAP�� �ʱⰪ ������ �����ϹǷ� �ش� �ʱⰪ�� �����ͷ� �����Ѵٸ�
*     X_CONNID             = 'X' " 'X' ���� �־� ��� �Ķ���� ���̾� ��� �˷��ִ� ����..
*     _SCOPE               = '2'
*     _WAIT                = 'X' " �� ���� �� ��õ� ���θ� ����(space or 'X')

*     _COLLECT             = 'X' " �Լ��� ȣ�� �� �� Lock ��°� �ƴ϶�
                                 " Lock1, Lock2, Lock3�� Lock�� �� ���� ���� �� ���
   EXCEPTIONS "�׻� ������ ��
     FOREIGN_LOCK         = 1
     SYSTEM_FAILURE       = 2
     OTHERS               = 3.

   CASE sy-subrc.
   	WHEN 0. "Lock ����
      p_answer = 1.
   	WHEN 1. "�ٸ� ����� �̹� Lock�� ����
      p_answer = 2.
   	WHEN OTHERS. "�ý��� ���
      p_answer = 3.
   ENDCASE.

ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  UNLOCKING
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      -->P_SPFLI_CARRID  text
*      -->P_SPFLI_CONNID  text
*----------------------------------------------------------------------*
FORM unlocking  USING    p_carrid TYPE spfli-carrid
                         p_connid TYPE spfli-connid.

  CALL FUNCTION 'DEQUEUE_EZ_CONN_SS36'
   EXPORTING
*     MODE_SPFLI       = 'E'
*     MANDT            = SY-MANDT
     CARRID           = p_carrid
     CONNID           = p_connid.
*     X_CARRID         = ' '
*     X_CONNID         = ' '
*     _SCOPE           = '3'
*     _SYNCHRON        = ' '
*     _COLLECT         = ' '.

ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  GET_DATA
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM get_data .

    SELECT SINGLE *
    FROM spfli
    INTO CORRESPONDING FIELDS OF sdyn_conn
    WHERE carrid = spfli-carrid
    AND connid = spfli-connid.

ENDFORM.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
