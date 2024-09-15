*&---------------------------------------------------------------------*
*& Report ZFORALL_SS36
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zforall_ss36.

* ���� ������ �������� �������� ��� �����
DATA it_spfli TYPE TABLE OF spfli.

* SPFLI
SELECT *
  FROM spfli
  INTO TABLE it_spfli
  WHERE countryfr = spfli~countryto.

DATA it_scarr TYPE TABLE OF scarr.

* it_spfli�� ���� �ִ� ��� �װ��縦 ��ȸ
* it_spfli���� �ߺ��� �װ��� �ڵ�� ����(OPTIONAL)

* 1) ��� ���� 1�� - OPTIONAL
SORT it_spfli BY carrid.
DELETE ADJACENT DUPLICATES FROM it_spfli COMPARING carrid.

* 2) ��� ���� 2��
* ���ͳ� ���̺��� ����ִٸ� scarr�� ��� �����͸� �������Ƿ� Ȯ�� �ؾ���
IF it_spfli IS NOT INITIAL.

  SELECT *
    FROM scarr
    INTO TABLE it_scarr
    FOR ALL ENTRIES IN it_spfli " ���������� �ߺ��� �����Ͱ� �ִٸ� �ϳ��� ������
    WHERE carrid = it_spfli-carrid. " �ߺ��� �װ��� �ڵ尡 �־ �� ���� ���

ENDIF.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
