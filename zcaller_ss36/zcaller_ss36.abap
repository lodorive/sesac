*&---------------------------------------------------------------------*
*& Report ZCALLER_SS36
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zcaller_ss36.

* ȭ�鿡�� �װ��� �ڵ带 �Է� �޾Ƽ� �ٸ� ���α׷� ȣ��
* ZBC400_CARRIER_S36

PARAMETERS p_car TYPE scarr-carrid.

*���� ȣ��
SUBMIT zbc400_carrier_s36
  WITH pa_car = p_car. "�ش� ���α׷��� �Ķ���� = �� ���α׷� �Ķ����
*AND RETURN. "ȣ�� �� ���� ���ƿ��� �ʰڴ�

*ABAP Dictionary
*CALL TRANSACTION 'SE11'.


WRITE: 'Done'.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
