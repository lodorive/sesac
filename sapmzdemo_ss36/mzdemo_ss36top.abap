*&---------------------------------------------------------------------*
*& Include MZDEMO_SS36TOP                                    Module Pool      SAPMZDEMO_SS36
*&
*&---------------------------------------------------------------------*
PROGRAM SAPMZDEMO_SS36.

* ȭ�鿡 �׸� ��Ʈ���Ŀ� ����� ���� �����ϱ�
TABLES zcalculator_ss36. "ABAP ��ųʸ��� ����� �� �ִ� ���� ����


* ���⸦ ���� ���� ����
DATA: gv_arg1 TYPE i,
      gv_arg2 TYPE i,
      gv_operator TYPE c LENGTH 1, " +, - , / , *
      gv_result TYPE i.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
