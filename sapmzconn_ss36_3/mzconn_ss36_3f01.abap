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
     DISPLAY_CANCEL_BUTTON       = ' ' "필요 없음
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

  "락 잡는 함수 호출
  CALL FUNCTION 'ENQUEUE_EZ_CONN_SS36'
   EXPORTING
*     MODE_SPFLI           = 'E' " E : 데이터 변경 시 Lock 잡음
*     MANDT                = SY-MANDT
     CARRID               = p_carrid
     CONNID               = p_connid
*     X_CARRID             = 'X' " SAP는 초기값 던지면 무시하므로 해당 초기값이 데이터로 존재한다면
*     X_CONNID             = 'X' " 'X' 값을 넣어 얘는 파라미터 값이야 라고 알려주는 거임..
*     _SCOPE               = '2'
*     _WAIT                = 'X' " 락 실패 시 재시도 여부를 결정(space or 'X')

*     _COLLECT             = 'X' " 함수를 호출 할 때 Lock 잡는게 아니라
                                 " Lock1, Lock2, Lock3의 Lock을 한 번에 잡을 때 사용
   EXCEPTIONS "항상 살려줘야 함
     FOREIGN_LOCK         = 1
     SYSTEM_FAILURE       = 2
     OTHERS               = 3.

   CASE sy-subrc.
   	WHEN 0. "Lock 성공
      p_answer = 1.
   	WHEN 1. "다른 사람이 이미 Lock을 잡음
      p_answer = 2.
   	WHEN OTHERS. "시스템 장애
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
