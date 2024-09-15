*&---------------------------------------------------------------------*
*&  Include           MZSTUDENT_SS36I01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0100 INPUT.

  CASE ok_code.
    WHEN 'MAIN'.
      CASE 'X'. "둘 중 누가 선택?
        WHEN gs_mode-display.
          io_command = 'D'.
        WHEN gs_mode-change.
          io_command = 'U'.
      ENDCASE.
      LEAVE TO SCREEN 200.
  ENDCASE.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  CHECK_MAJOR  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE check_major INPUT.

  SELECT COUNT( * )
    FROM zmajor_ss36
    WHERE major = zstd_ss36-major.

  IF sy-subrc <> 0.
    MESSAGE i011(zmessage_ss36)
    WITH zstd_ss36-major.
  ENDIF.

ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  GET_DATA  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE get_data INPUT.

  SELECT SINGLE *
    FROM zstd_ss36
    INTO CORRESPONDING FIELDS OF zstd_ss36
    WHERE id = zstd_ss36-id
    AND major = zstd_ss36-major.

ENDMODULE.

*&---------------------------------------------------------------------*
*&      Module  EXIT  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE exit INPUT.

  CASE ok_code.
    WHEN 'BACK'.
      LEAVE PROGRAM.
    WHEN 'EXIT'.
      LEAVE PROGRAM.
  ENDCASE.

ENDMODULE.

*&---------------------------------------------------------------------*
*&      Module  GET_SUBJECTS  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE get_subjects INPUT.

  SELECT COUNT( DISTINCT subject )
    FROM zscore_ss36
    INTO gv_total
    WHERE id = zstd_ss36-id.

ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  GET_GENDER  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE get_gender INPUT.

  DATA lt_domvalues TYPE bbpt_domvalue_keys.
  DATA lw_domvalue  TYPE bbp_domvalue_keys.

  CALL FUNCTION 'BBP_GET_DOMVALUES_F4'
    EXPORTING
      iv_domain_name = 'ZGENDER_SS36'
    TABLES
      et_domvalues   = lt_domvalues.

  READ TABLE lt_domvalues INTO lw_domvalue
  WITH KEY domain_value = zstd_ss36-gender.
  gv_gendert = lw_domvalue-domain_text.

ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  EXIT2  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE exit2 INPUT.

  CASE ok_code.
    WHEN 'BACK'.
      LEAVE TO SCREEN 100.
    WHEN 'EXIT'.
      LEAVE PROGRAM.
  ENDCASE.

ENDMODULE.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
