*&---------------------------------------------------------------------*
*&  Include           MZDEMO_SS36I01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  CALCULATE  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*MODULE calculate INPUT.
*
*  " 계산기 로직을 구현
*  CASE gv_operator.
*    WHEN '+'.
*      gv_result = gv_arg1 + gv_arg2.
*    WHEN '-'.
*      gv_result = gv_arg1 - gv_arg2.
*    WHEN '*'.
*      gv_result = gv_arg1 * gv_arg2.
*    WHEN '/'.
*      gv_result = gv_arg1 / gv_arg2.
*  ENDCASE.
*
*
*ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  CALCULATE_DIC  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE calculate_dic INPUT.

  CASE zcalculator_ss36-operator.

    WHEN '+'.
      zcalculator_ss36-result =
      zcalculator_ss36-arg1 + zcalculator_ss36-arg2.
    WHEN '-'.
      zcalculator_ss36-result =
      zcalculator_ss36-arg1 - zcalculator_ss36-arg2.
    WHEN '*'.
      zcalculator_ss36-result =
      zcalculator_ss36-arg1 * zcalculator_ss36-arg2.
    WHEN '/'.
      zcalculator_ss36-result =
      zcalculator_ss36-arg1 / zcalculator_ss36-arg2.

  ENDCASE.

ENDMODULE.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
