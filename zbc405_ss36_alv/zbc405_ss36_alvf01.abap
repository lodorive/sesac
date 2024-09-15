*----------------------------------------------------------------------*
***INCLUDE ZBC405_SS36_ALVF01.
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Form  SET_ALV
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Form  SET_ALV
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM set_alv .

    gs_variant-report = sy-cprog.
    gs_variant-variant = pa_lv.

    gv_save = 'A'.

    gs_layout-sel_mode = 'A'. "라인 선택
    gs_layout-info_fname = 'COLOR'. "라인 컬러

    gs_layout-excp_fname = 'LIGHT'.

    CLEAR gs_field_cat.
    gs_field_cat-fieldname = 'SEATSOCC'.
    gs_field_cat-do_sum = 'X'.
    APPEND gs_field_cat TO gt_field_cat.

    CLEAR gs_field_cat.
    gs_field_cat-fieldname = 'PAYMENTSUM'.
    gs_field_cat-no_out = 'X'.
    APPEND gs_field_cat TO gt_field_cat.

    CLEAR gs_field_cat.
    gs_field_cat-fieldname = 'LIGHT'.
    gs_field_cat-coltext = 'Utiliztion'(h02).
    APPEND gs_field_cat TO gt_field_cat.

    CLEAR gs_field_cat.
    gs_field_cat-fieldname = 'CHANGES_POSSIBLE'.
    gs_field_cat-icon = 'X'.
    gs_field_cat-col_pos = 5.
    gs_field_cat-coltext = 'Changes possible'(h03).
    gs_field_cat-tooltip = 'Are changes possible?'(t01).
    APPEND gs_field_cat TO gt_field_cat.

ENDFORM.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
