*&---------------------------------------------------------------------*
*& Report ZCURRENCY_TEXT_SS36
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZCURRENCY_TEXT_SS36.

PARAMETERS p_curr TYPE TCURT-WAERS. "ȭ�����

* �Լ��� ����� ��� �Լ�
DATA result TYPE TCURT.

CALL FUNCTION 'TCURT_SINGLE_READ'
  EXPORTING
    i_spras                  = sy-langu
    i_waers                  = p_curr
*   I_RESET_BUFFER           =
*   I_BYPASSING_BUFFER       =
 IMPORTING
   O_TCURT                  = result
 EXCEPTIONS
   NOT_FOUND                = 1
   PARAMETER_ERROR          = 2
   OTHERS                   = 3.

WRITE:result-ltext.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
