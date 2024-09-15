*&---------------------------------------------------------------------*
*&  Include           MZDEMO_SS36O01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  CALCULATE2  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE calculate2 OUTPUT.

  " 계산기 로직을 구현
  CASE gv_operator.
    WHEN '+'.
      gv_result = gv_arg1 + gv_arg2.
    WHEN '-'.
      gv_result = gv_arg1 - gv_arg2.
    WHEN '*'.
      gv_result = gv_arg1 * gv_arg2.
    WHEN '/'.
      gv_result = gv_arg1 / gv_arg2.
  ENDCASE.


ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  INIT  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE init OUTPUT.

  IF zcalculator_ss36-operator IS INITIAL.
    zcalculator_ss36-operator = '*'.
  ENDIF.

ENDMODULE.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
