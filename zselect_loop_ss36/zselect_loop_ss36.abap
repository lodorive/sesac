*&---------------------------------------------------------------------*
*& Report ZSELECT_LOOP_SS36
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZSELECT_LOOP_SS36.

* �Է� �Ķ����
PARAMETERS p_cur TYPE S_CURRCODE. "�װ����� ȭ�����

* ENDSELECT ��� �� LOOP�� ���� ������
* ��Ʈ���� Ÿ������ ��� �� ���� ���� ������ ��
DATA gs_scarr TYPE scarr.

* SELECT SINGLE�� ���� ������ ENDSELECT�� ���ƾ� �Ѵ�
* SELECT LOOP (���ǿ� �´� �����͸�ŭ LOOP�� ����) -> sy-dbcnt
SELECT *
  FROM SCARR
  INTO gs_scarr
  WHERE currcode = p_cur.

  WRITE:/ sy-dbcnt, gs_scarr-carrid, gs_scarr-carrname.
ENDSELECT.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
