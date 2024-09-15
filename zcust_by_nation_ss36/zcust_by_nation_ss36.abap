*&---------------------------------------------------------------------*
*& Report ZCUST_BY_NATION_SS36
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zcust_by_nation_ss36.

* ���α׷� �̸� : ZCUST_BY_NATION_SS36
* ȭ�鿡�� ���� �ڵ带 �Է� �޾Ƽ� �ش� ������ ���� ��� ����ϴ� ���α׷��� ����
* �Է� �Ķ����
PARAMETERS p_cou TYPE scustom-country.

* ��Ʈ���� Ÿ���� ��� �� ���� ����
DATA gs_scustom TYPE scustom.

* SELECT LOOP
SELECT id name country telephone email

  FROM scustom
  INTO CORRESPONDING FIELDS OF gs_scustom
  WHERE country = p_cou.

  "��ȭ��ȣ�� ���� ���
  IF gs_scustom-telephone IS INITIAL.
     gs_scustom-telephone = 'N/A'.
    ENDIF.

  "�̸����� ���� ���
  IF gs_scustom-email IS INITIAL.
    gs_scustom-email = 'N/A'.
    ENDIF.

  WRITE:/ sy-dbcnt, gs_scustom-id, gs_scustom-name,
  gs_scustom-country, gs_scustom-telephone, gs_scustom-email.

ENDSELECT.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
