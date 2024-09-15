*----------------------------------------------------------------------*
***INCLUDE BC414_SQL_TRAVELAG_SF01
*----------------------------------------------------------------------*

*&---------------------------------------------------------------------*
*&      Form  GET_SELECTED_LINES
*&---------------------------------------------------------------------*
*      -->PT_TRAVELAG      text
*      <--CT_TRAVELAG_SEL  text
*----------------------------------------------------------------------*
FORM get_selected_lines  USING    pt_travelag     TYPE gty_t_stravelag
                         CHANGING ct_travelag_sel TYPE gty_t_stravelag.

  DATA lt_ids      TYPE lvc_t_roid.
  DATA ls_id       TYPE lvc_s_roid.
  DATA ls_travelag TYPE stravelag.

  CLEAR ct_travelag_sel.

  go_alv->get_selected_rows(
    IMPORTING
      et_row_no     = lt_ids ).

  LOOP AT lt_ids INTO ls_id.
    READ TABLE pt_travelag INTO ls_travelag INDEX ls_id-row_id.
    APPEND ls_travelag TO ct_travelag_sel.
  ENDLOOP.

ENDFORM.                    " GET_SELECTED_LINES


*&---------------------------------------------------------------------*
*&      Form  POPUP_TO_CONFIRM_LOSS_OF_DATA
*&---------------------------------------------------------------------*
FORM popup_to_confirm_loss_of_data.

  DATA lv_result TYPE c LENGTH 1.

  CALL FUNCTION 'POPUP_TO_CONFIRM'
    EXPORTING
      titlebar              = TEXT-009
      text_question         = TEXT-008
      display_cancel_button = space
    IMPORTING
      answer                = lv_result.
  CASE lv_result.
    WHEN '1'.
      LEAVE TO SCREEN '0000'.
    WHEN '2'.
      LEAVE TO SCREEN '0200'.
  ENDCASE.

ENDFORM.                               " POPUP_TO_CONFIRM_LOSS_OF_DATA


*&---------------------------------------------------------------------*
*&      Form  READ_DATA
*&---------------------------------------------------------------------*
*      <--CT_TRAVELAG  text
*----------------------------------------------------------------------*
FORM read_data CHANGING ct_travelag TYPE gty_t_stravelag.

  SELECT * FROM stravelag INTO TABLE ct_travelag.

ENDFORM.                               " READ_DATA


************************************************************************
********************************* YOUR CODE ****************************
************************************************************************
*&---------------------------------------------------------------------*
*&      Form  SAVE
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      -->P_GT_TRAVELAG_SEL  text
*----------------------------------------------------------------------*
FORM save  USING p_upd_table TYPE gty_t_stravelag.
* 원래는 VALUE를 붙이는게 맞지만
* 데이터가 양이 많거나 하다면....(속도개선)
* Ref 하는게 낫다

  UPDATE stravelag
  FROM TABLE p_upd_table.

  IF sy-subrc <> 0.
    MESSAGE i048.
  ELSE.
    MESSAGE s030.
  ENDIF.

ENDFORM.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
