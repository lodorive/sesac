*&---------------------------------------------------------------------*
*& Report ZFUNCMODLUE_SS36
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZFUNCMODLUE_SS36.

* ȭ�鿡�� ���� 2�� �Է� �޾� Power ���� ���ϴ� ���α׷�
* �Լ� ��� : BC400_MOS_POWER

* �Է� �� 2��
* �Ķ���ʹ� �Լ��� Ÿ���� �°� �����ؾ� �Ѵ�
PARAMETERS: p_base TYPE BC400_COMPUTE_BASE,
            p_power TYPE BC400_COMPUTE_POWER.

* ���� �� 1��
DATA gv_result TYPE BC400_COMPUTE_RESULT.

CALL FUNCTION 'BC400_MOS_POWER'
  EXPORTING
   iv_base                     = p_base
   IV_POWER                    = p_power
 IMPORTING
   EV_RESULT                   = gv_result
 EXCEPTIONS "sy-subrc ����ó��
   POWER_VALUE_TOO_HIGH        = 1
   RESULT_VALUE_TOO_HIGH       = 2
   OTHERS                      = 3.

CASE sy-subrc.
  WHEN 0.
    WRITE:/'Result', gv_result.
  WHEN 1.
    MESSAGE i002(ZMESSAGE_SS36).
  WHEN 2.
    MESSAGE i003(ZMESSAGE_SS36).
  WHEN 3.
    MESSAGE i004(ZMESSAGE_SS36).
  WHEN OTHERS.
ENDCASE.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
