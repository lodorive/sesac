*&---------------------------------------------------------------------*
*& Report ZOPENSQL_S36
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZOPENSQL_S36_2.

* ȭ�鿡�� �װ��� �ڵ带 �Է¹޾�
* �װ��� �̸��� ȭ������� ����ϴ� ���α׷����� �����Ͻÿ�

PARAMETERS p_code TYPE scarr-carrid. "ȭ�鿡�� �װ��� �ڵ带 �Է¹���
DATA gv_scarr TYPE scarr.

SELECT SINGLE carrname currcode
  FROM scarr
*  INTO (gv_scarr-carrname, gv_scarr-currcode)
  INTO CORRESPONDING FIELDS OF gv_scarr
 WHERE carrid = p_code.

WRITE:/ 'Airline Name:', gv_scarr-carrname.
WRITE:/ 'Airline Currency:', gv_scarr-currcode.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
