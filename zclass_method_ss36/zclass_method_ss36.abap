*&---------------------------------------------------------------------*
*& Report ZCLASS_METHOD_SS36
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZCLASS_METHOD_SS36.

* �Է� : Base Value, Power Value
* ��� : ���� Power ��

PARAMETERS: p_base TYPE BC400_COMPUTE_BASE ,
            p_power TYPE BC400_COMPUTE_POWER.

* ��� �� ���� �Լ�
DATA gv_result TYPE BC400_COMPUTE_RESULT.

* Class�� Method ȣ��
* Class : CL_BC400_COMPUTE
* Mothod : GET_POWER

TRY.
CALL METHOD cl_bc400_compute=>get_power
  EXPORTING
    iv_base   = p_base
    iv_power  = p_power
  IMPORTING
    ev_result = gv_result
    .

  WRITE: gv_result.

 CATCH cx_bc400_power_too_high .
   WRITE: 'Power value is too high!'.
 CATCH cx_bc400_result_too_high .
   WRITE: 'Result valu is too big!'.
ENDTRY.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
