*&---------------------------------------------------------------------*
*& Report ZCUST_BY_NATION_SS36
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zcust_by_nation_ss36_2.

* ���α׷� �̸� : ZCUST_BY_NATION_SS36
* ȭ�鿡�� ���� �ڵ带 �Է� �޾Ƽ� �ش� ������ ���� ��� ����ϴ� ���α׷��� ����

* �Է� �Ķ����
PARAMETERS p_cou TYPE scustom-country.

DATA gs_scustom TYPE scustom. " ��Ʈ���� Ÿ���� ��� �� ���� ����
DATA gt_scustom LIKE TABLE OF gs_scustom. " ���ͳ� ���̺�

* SELECT LOOP
SELECT id name country telephone email

  FROM scustom
  INTO CORRESPONDING FIELDS OF TABLE gt_scustom "608���� �����Ͱ� �� ���� ���(US �� ��)
  WHERE country = p_cou.

WRITE: sy-dbcnt.

* ���ͳ� ���̺� ���� ���鼭 ���
LOOP AT gt_scustom INTO gs_scustom.

  " �̸����� ��� ������
  IF gs_scustom-email IS INITIAL.
    gs_scustom-email = 'N/A'.
  ENDIF.
  " ��ȭ��ȣ�� ��� ������
  IF gs_scustom-telephone IS INITIAL.
    gs_scustom-telephone = 'N/A'.
  ENDIF.

WRITE: sy-tabix,
       gs_scustom-id,
       gs_scustom-name,
       gs_scustom-country,
       gs_scustom-telephone,
       gs_scustom-email.

ENDLOOP.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
