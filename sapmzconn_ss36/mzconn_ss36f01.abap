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

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
